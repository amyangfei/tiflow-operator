module github.com/pingcap/tiflow-operator

go 1.18

require (
	github.com/google/go-cmp v0.5.8
	github.com/pingcap/errors v0.11.0
	github.com/pingcap/tiflow-operator/api v0.0.0
	github.com/stretchr/testify v1.8.0
	k8s.io/api v0.24.0
	k8s.io/apimachinery v0.24.0
	k8s.io/client-go v0.24.0
	k8s.io/klog/v2 v2.70.1
	k8s.io/kubernetes v1.24.0
	k8s.io/utils v0.0.0-20220728103510-ee6ede2d64ed
	sigs.k8s.io/controller-runtime v0.11.0
)

require (
	cloud.google.com/go v0.97.0 // indirect
	github.com/Azure/go-autorest v14.2.0+incompatible // indirect
	github.com/Azure/go-autorest/autorest v0.11.18 // indirect
	github.com/Azure/go-autorest/autorest/adal v0.9.13 // indirect
	github.com/Azure/go-autorest/autorest/date v0.3.0 // indirect
	github.com/Azure/go-autorest/logger v0.2.1 // indirect
	github.com/Azure/go-autorest/tracing v0.6.0 // indirect
	github.com/BurntSushi/toml v1.2.0 // indirect
	github.com/PuerkitoBio/purell v1.1.1 // indirect
	github.com/PuerkitoBio/urlesc v0.0.0-20170810143723-de5bf2ad4578 // indirect
	github.com/beorn7/perks v1.0.1 // indirect
	github.com/cespare/xxhash/v2 v2.1.2 // indirect
	github.com/davecgh/go-spew v1.1.1 // indirect
	github.com/emicklei/go-restful/v3 v3.8.0 // indirect
	github.com/evanphx/json-patch v4.12.0+incompatible // indirect
	github.com/form3tech-oss/jwt-go v3.2.3+incompatible // indirect
	github.com/fsnotify/fsnotify v1.5.4 // indirect
	github.com/go-logr/logr v1.2.3 // indirect
	github.com/go-logr/zapr v1.2.3 // indirect
	github.com/go-openapi/jsonpointer v0.19.5 // indirect
	github.com/go-openapi/jsonreference v0.19.5 // indirect
	github.com/go-openapi/swag v0.19.14 // indirect
	github.com/gogo/protobuf v1.3.2 // indirect
	github.com/golang/groupcache v0.0.0-20210331224755-41bb18bfe9da // indirect
	github.com/golang/protobuf v1.5.2 // indirect
	github.com/google/gnostic v0.5.7-v3refs // indirect
	github.com/google/gofuzz v1.1.0 // indirect
	github.com/google/uuid v1.1.2 // indirect
	github.com/imdario/mergo v0.3.12 // indirect
	github.com/josharian/intern v1.0.0 // indirect
	github.com/json-iterator/go v1.1.12 // indirect
	github.com/mailru/easyjson v0.7.6 // indirect
	github.com/matttproud/golang_protobuf_extensions v1.0.2-0.20181231171920-c182affec369 // indirect
	github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd // indirect
	github.com/modern-go/reflect2 v1.0.2 // indirect
	github.com/mohae/deepcopy v0.0.0-20170929034955-c48cc78d4826 // indirect
	github.com/munnerz/goautoneg v0.0.0-20191010083416-a7dc8b61c822 // indirect
	github.com/pkg/errors v0.9.1 // indirect
	github.com/pmezard/go-difflib v1.0.0 // indirect
	github.com/prometheus/client_golang v1.12.2 // indirect
	github.com/prometheus/client_model v0.2.0 // indirect
	github.com/prometheus/common v0.32.1 // indirect
	github.com/prometheus/procfs v0.7.3 // indirect
	github.com/spf13/pflag v1.0.5 // indirect
	go.uber.org/atomic v1.7.0 // indirect
	go.uber.org/multierr v1.6.0 // indirect
	go.uber.org/zap v1.21.0 // indirect
	golang.org/x/crypto v0.0.0-20220214200702-86341886e292 // indirect
	golang.org/x/net v0.0.0-20220722155237-a158d28d115b // indirect
	golang.org/x/oauth2 v0.0.0-20211104180415-d3ed0bb246c8 // indirect
	golang.org/x/sys v0.0.0-20220722155257-8c9f86f7a55f // indirect
	golang.org/x/term v0.0.0-20210927222741-03fcf44c2211 // indirect
	golang.org/x/text v0.3.7 // indirect
	golang.org/x/time v0.0.0-20220609170525-579cf78fd858 // indirect
	gomodules.xyz/jsonpatch/v2 v2.2.0 // indirect
	google.golang.org/appengine v1.6.7 // indirect
	google.golang.org/protobuf v1.28.0 // indirect
	gopkg.in/inf.v0 v0.9.1 // indirect
	gopkg.in/yaml.v2 v2.4.0 // indirect
	gopkg.in/yaml.v3 v3.0.1 // indirect
	k8s.io/apiextensions-apiserver v0.25.0 // indirect
	k8s.io/apiserver v0.24.0 // indirect
	k8s.io/component-base v0.25.0 // indirect
	k8s.io/kube-openapi v0.0.0-20220803162953-67bda5d908f1 // indirect
	sigs.k8s.io/json v0.0.0-20220713155537-f223a00ba0e2 // indirect
	sigs.k8s.io/structured-merge-diff/v4 v4.2.3 // indirect
	sigs.k8s.io/yaml v1.3.0 // indirect
)

replace github.com/pingcap/tiflow-operator/api => ./api

replace k8s.io/api => k8s.io/api v0.24.0

replace k8s.io/apiextensions-apiserver => k8s.io/apiextensions-apiserver v0.24.0

replace k8s.io/apimachinery => k8s.io/apimachinery v0.24.0

replace k8s.io/apiserver => k8s.io/apiserver v0.24.0

replace k8s.io/cli-runtime => k8s.io/cli-runtime v0.24.0

replace k8s.io/client-go => k8s.io/client-go v0.24.0

replace k8s.io/code-generator => k8s.io/code-generator v0.24.0

replace k8s.io/csi-api => k8s.io/csi-api v0.0.0-20190118125032-c4557c74373f

replace k8s.io/kube-aggregator => k8s.io/kube-aggregator v0.24.0

replace k8s.io/kube-controller-manager => k8s.io/kube-controller-manager v0.24.0

replace k8s.io/kube-proxy => k8s.io/kube-proxy v0.24.0

replace k8s.io/kubelet => k8s.io/kubelet v0.24.0

replace k8s.io/metrics => k8s.io/metrics v0.24.0

replace k8s.io/sample-apiserver => k8s.io/sample-apiserver v0.24.0

replace k8s.io/sample-cli-plugin => k8s.io/sample-cli-plugin v0.24.0

replace k8s.io/sample-controller => k8s.io/sample-controller v0.24.0

replace k8s.io/cloud-provider => k8s.io/cloud-provider v0.24.0

replace k8s.io/cluster-bootstrap => k8s.io/cluster-bootstrap v0.24.0

replace k8s.io/component-base => k8s.io/component-base v0.24.0

replace k8s.io/cri-api => k8s.io/cri-api v0.24.0

replace k8s.io/csi-translation-lib => k8s.io/csi-translation-lib v0.24.0

replace k8s.io/kubectl => k8s.io/kubectl v0.24.0

replace k8s.io/legacy-cloud-providers => k8s.io/legacy-cloud-providers v0.24.0

replace k8s.io/node-api => k8s.io/node-api v0.0.0-20190918163711-2299658ad911

replace github.com/uber-go/atomic => go.uber.org/atomic v1.5.0

replace github.com/Azure/go-autorest => github.com/Azure/go-autorest v14.2.0+incompatible

replace github.com/prometheus/client_golang => github.com/prometheus/client_golang v1.11.0

replace k8s.io/controller-manager => k8s.io/controller-manager v0.24.0

replace k8s.io/kube-scheduler => k8s.io/kube-scheduler v0.24.0

replace k8s.io/component-helpers => k8s.io/component-helpers v0.24.0

replace k8s.io/mount-utils => k8s.io/mount-utils v0.24.0

replace k8s.io/pod-security-admission => k8s.io/pod-security-admission v0.24.0
