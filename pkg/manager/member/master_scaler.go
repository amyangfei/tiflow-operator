package member

import (
	"context"
	"fmt"
	"time"

	apps "k8s.io/api/apps/v1"
	autoscaling "k8s.io/api/autoscaling/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/kubernetes"
	"k8s.io/klog/v2"
	"sigs.k8s.io/controller-runtime/pkg/client"

	"github.com/pingcap/tiflow-operator/api/v1alpha1"
	"github.com/pingcap/tiflow-operator/pkg/controller"
	"github.com/pingcap/tiflow-operator/pkg/tiflowapi"
)

type masterScaler struct {
	cli       client.Client
	clientSet kubernetes.Interface
}

// NewMasterScaler returns a DMScaler
func NewMasterScaler(cli client.Client, clientSet kubernetes.Interface) Scaler {
	return &masterScaler{
		cli:       cli,
		clientSet: clientSet,
	}
}

func (s masterScaler) Scale(meta metav1.Object, oldSts *apps.StatefulSet, newSts *apps.StatefulSet) error {
	actual := *oldSts.Spec.Replicas
	desired := *newSts.Spec.Replicas

	scaling := desired - actual
	if scaling > 0 {
		return s.ScaleOut(meta, oldSts, newSts)
	} else if scaling < 0 {
		return s.ScaleIn(meta, oldSts, newSts)
	}
	return nil
}

func (s masterScaler) ScaleOut(meta metav1.Object, actual *apps.StatefulSet, desired *apps.StatefulSet) error {
	tc, ok := meta.(*v1alpha1.TiflowCluster)
	if !ok {
		return nil
	}

	ns := tc.GetNamespace()
	tcName := tc.GetName()
	stsName := actual.GetName()

	if !tc.Status.Master.Synced {
		return fmt.Errorf("tiflow cluster: [%s/%s]'s tiflow-master status sync failed, can't scale up now",
			ns, tcName)
	}

	klog.Infof("start to scaling up tiflow-master statefulSet %s for [%s/%s], actual: %d, desired: %d",
		stsName, ns, tcName, *actual.Spec.Replicas, *desired.Spec.Replicas)

	up := *desired.Spec.Replicas - *actual.Spec.Replicas
	current := *actual.Spec.Replicas
	ctx := context.TODO()

	for i := up; i > 0; i-- {
		klog.Infof("scaling up statefulSet %s of master, current: %d, desired: %d",
			stsName, current, current+1)

		if err := s.SetReplicas(ctx, actual, uint(current+1)); err != nil {
			return err
		}

		if err := s.WaitUntilRunning(ctx); err != nil {
			return err
		}

		if err := s.WaitUntilHealthy(ctx, uint(current+1)); err != nil {
			return err
		}

		current++
		time.Sleep(defaultSleepTime)
	}

	klog.Infof("scaling up is done, tiflow-master statefulSet %s for [%s/%s], current: %d, desired: %d",
		stsName, ns, tcName, current, *desired.Spec.Replicas)

	return nil
}

func (s masterScaler) ScaleIn(meta metav1.Object, actual *apps.StatefulSet, desired *apps.StatefulSet) error {
	tc, ok := meta.(*v1alpha1.TiflowCluster)
	if !ok {
		return nil
	}

	ns := tc.GetNamespace()
	tcName := tc.GetName()
	stsName := actual.GetName()

	if !tc.Status.Master.Synced {
		return fmt.Errorf("tiflow cluster: %s/%s's tiflow-master status sync failed, can't scale out now",
			ns, tcName)
	}

	klog.Infof("start to scaling down tiflow-master statefulSet %s for [%s/%s], actual: %d, desired: %d",
		stsName, ns, tcName, *actual.Spec.Replicas, *desired.Spec.Replicas)

	down := *actual.Spec.Replicas - *desired.Spec.Replicas
	current := *actual.Spec.Replicas
	ctx := context.TODO()

	for i := down; i > 0; i-- {
		klog.Infof("scaling down statefulSet %s of master, current: %d, desired: %d",
			stsName, current, current-1)

		if err := s.EvictLeader(tc, current-1); err != nil {
			return err
		}

		if err := s.SetReplicas(ctx, actual, uint(current-1)); err != nil {
			return err
		}

		if err := s.WaitUntilHealthy(ctx, uint(current-1)); err != nil {
			return err
		}

		current--
		time.Sleep(defaultSleepTime)
	}

	klog.Infof("scaling down is done, tiflow-master statefulSet %s for [%s/%s], current: %d, desired: %d",
		stsName, ns, tcName, current, *desired.Spec.Replicas)

	return nil
}

func (s *masterScaler) EvictLeader(tc *v1alpha1.TiflowCluster, ordinal int32) error {
	ns := tc.GetNamespace()
	tcName := tc.GetName()
	memberName := ordinalPodName(v1alpha1.TiFlowMasterMemberType, tcName, ordinal)

	// If the tiflow-master pod was tiflow-master leader during scale-in, we would evict tiflow-master leader first
	// If it's the last member we don't need to do this because we will delete this later
	if ordinal > 0 {
		if tc.Status.Master.Leader.ClientURL == memberName {
			klog.Infof("tiflow cluster [%s/%s]'s tiflow-master pod [%s/%s] is transferring tiflow-master leader",
				ns, tcName, ns, memberName)
			masterPeerClient := tiflowapi.GetMasterClient(s.cli, ns, tcName, memberName, tc.IsClusterTLSEnabled())
			err := masterPeerClient.EvictLeader()
			if err != nil {
				return err
			}
			return controller.RequeueErrorf("tiflow cluster [%s/%s]'s tiflow-master pod [%s/%s] is transferring tiflow-master leader, can't scale-in now",
				ns, tcName, ns, memberName)
		}
	}
	return nil
}

func (s *masterScaler) SetReplicas(ctx context.Context, actual *apps.StatefulSet, desired uint) error {
	_, err := s.clientSet.AppsV1().StatefulSets(actual.Namespace).UpdateScale(ctx, actual.Name, &autoscaling.Scale{
		ObjectMeta: metav1.ObjectMeta{
			Name:      actual.Name,
			Namespace: actual.Namespace,
		},
		Spec: autoscaling.ScaleSpec{
			Replicas: int32(desired),
		},
	}, metav1.UpdateOptions{})
	if err != nil {
		return fmt.Errorf("failed to update statefulSet %s of master, error: %v",
			actual.Name, err)
	}

	return nil
}

// WaitUntilRunning blocks until the tiflow-mater statefulset has the expected number of pods running but not necessarily ready
func (s *masterScaler) WaitUntilRunning(ctx context.Context) error {
	//TODO implement me
	//panic("implement me")
	return nil
}

// WaitUntilHealthy blocks until the tiflow-master stateful set has exactly `prune` healthy replicas.
func (s *masterScaler) WaitUntilHealthy(ctx context.Context, scale uint) error {
	//TODO implement me
	//panic("implement me")
	return nil
}
