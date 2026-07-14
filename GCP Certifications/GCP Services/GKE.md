# Google Kubernetes Engine (GKE)
Google Kubernetes Engine (GKE) provides a managed environment for deploying, managing, and scaling your containerized applications using Google infrastructure. The GKE environment consists of multiple machines (specifically, Compute Engine instances) grouped together to form a cluster.

GKE contains at least one _cluster master_ and multiple worker machines called _nodes_.

**Upgrading Clusters**

_Master_:
```
gcloud container clusters upgrade [cluster-name] \
  --master --cluster-version [cluster-version]
```
_Nodes_:
```
gcloud container clusters upgrade [cluster-name] \
  --node-pool=[node-pool-name] \
  --cluster-version [cluster-version]
```

Disregard the flag `--cluster-version` to upgrade to the default version.

You can use the `rollback` command to rollback node pools that failed to upgrade or whose upgrades were cancelled to their previous Kubernetes version.

### Cluster Master
The master node runs the Kubernetes control plane, which includes the _API Server_, scheduler and resource controllers. The master lifecycle is managed by GKE (Google) when you create or delete a cluster. It runs on a VM in a VPC network contained in a project owned by Google.

GKE cluster masters are automatically upgraded to run new versions of Kubernetes as those versions become stable. This can also be manually done.

The master is responsible for deciding what runs on all of the cluster's nodes.

### Nodes
A cluster typically has one or more _nodes_ which run containerized applications and/or workloads. These are compute engine VM instances, which are are created by GKE.

Each node is managed by the master and can be setup to have auto-upgrades and repairs.

**Enable/disable auto-upgrad on existing node pool**

```
gcloud container node-pools update node-pool-name --cluster cluster-name \
    --zone compute-zone --enable-autoupgrade |no-enable-autoupgrade
```
**Creating a cluster or node pool with node auto-upgrades enabled**

```
gcloud container clusters create cluster-name --zone compute-zone \
    --enable-autoupgrade
```
```
gcloud container node-pools create node-pool-name --cluster cluster-name \
    --zone compute-zone --enable-autoupgrade
```

### Standard vs Autopilot

* Standard
  - Provides advanced configuration flexibility over the cluster’s underlying infrastructure.
  - Cluster configurations needed for the production workloads are determined by you
  - Regional or Zonal
  - You manually provision additional resources and set overall cluster size. Configure cluster autoscaling and node auto-provisioning to help automate the process.
  - Choice of Container-Optimized OS with containerd or docker, Ubuntu with containerd or docker, Windows Server LTSC/SAC
* Autopilot
  - Provides a fully provisioned and managed cluster configuration.
  - Cluster configuration options are made for you.
  - Autopilot clusters are pre-configured with an optimized cluster configuration that is ready for production workloads.
  - GKE manages the entire underlying infrastructure of the clusters, including the control plane, nodes, and all system components.
  - Clusters pre-configured and Regional
  - Dynamically provisions resources based on your Pod specs
  - Pre-configured Container-Optimized OS with containerd
  - Pre-configured with Workload Identity


### Sole-tenant Nodes
Sole-tenant nodes are dedicated physical servers that run a project's VMs. This allows isolation from VMs in other projects or groups you VMs together on the same host hardware.

**Sole-tenant node template**
```
gcloud compute sole-tenancy node-templates create template-name \
    --region compute-region --node-requirements vCPU=any,memory=any,localSSD=0
```

**Sole-tenant node group**
```
gcloud compute sole-tenancy node-groups create group-name --zone compute-zone \
  --node-template template-name --target-size target-size
```

**GKE Node pool using sole-tenant node group**

```
 gcloud container node-pools create node-pool-name \
   --node-group group-name --cluster cluster-name \
   --zone compute-zone --machine-type=node-group-machine-type \
   --node-locations=node-group-zone
```
Replace _group-name_ with the _sole-tenant group_ created.

**Deploying Services to specific node pools**
When you define a [Service](https://kubernetes.io/docs/concepts/services-networking/service/), you can indirectly control which node pool it is deployed into. The node pool is not dependent on the configuration of the Service, but on the configuration of the Pod.

* You can explicitly deploy a Pod to a specific node pool by setting a [nodeSelector](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/) in the Pod manifest. This forces a Pod to run only on nodes in that node pool.

* You can specify resource requests for the containers. The Pod only runs on nodes that satisfy the resource requests. For instance, if the Pod definition includes a container that requires four CPUs, the Service does not select Pods running on Nodes with two CPUs.

Example for deploying a Pod to a specific node pool:

```
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    env: test
spec:
  containers:
  - name: nginx
    image: nginx
    imagePullPolicy: IfNotPresent
  nodeSelector:
    cloud.google.com/gke-nodepool: [nodepool-name]
```

**Node Taints**
When you schedule workloads to be deployed on your cluster, node taints help you control which nodes they are allowed to run on.

A _node taint_ lets you mark a node so that the scheduler avoids or prevents using it for certain Pods. A complementary feature, tolerations, lets you designate Pods that can be used on "tainted" nodes.

Node taints are key-value pairs associated with an effect. Here are the available effects:

* `NoSchedule`:
  * Pods that do not tolerate this taint are not scheduled on the node; existing Pods are not evicted from the node.
* `PreferNoSchedule`:
  * Kubernetes avoids scheduling Pods that do not tolerate this taint onto the node.
* `NoExecute`:
  * Pod is evicted from the node if it is already running on the node, and is not scheduled onto the node if it is not yet running on the node

You can assign tainst to both the cluster and the node-pool

Command assigning taints to the cluster at creation time:
```
gcloud container clusters create [cluster-name]\
  --node-taints [key]=[value:effect]
```
ex:
```
gcloud container clusters create example-cluster \
  --node-taints dedicated=experimental:PreferNoSchedule
```

Command assigning taints at node-pool creation:
```
gcloud container node-pools create [pool-name] \
  --cluster [cluster-name] \
  --node-taints [key]=[value:effect]
```

Ex:
```
gcloud container node-pools create example-pool --cluster example-cluster \
  --node-taints dedicated=experimental:NoSchedule
```
```
gcloud container node-pools create example-pool-2 --cluster example-cluster \
  --node-taints special=gpu:NoExecute
```

You can configure Pods to tolerate a taint by including the `tolerations` field in the Pods's spec.

```
tolerations:
- key: dedicated
  operator: Equal
  value: experimental
  effect: NoSchedule
```

You can also add taints to exists nodes by leveraging `kubectl`:

```
kubectl taint nodes [node-name] [key]=[value:effect]
```

### Pods
The smallest, most basic deployable objects in Kubernetes. A Pod represents a single instance of a running process in your cluster.

Pods contain one or more containers, such as Docker containers. When a Pod runs multiple containers, the containers are managed as a single entity and share the Pod's resources. Generally, running multiple containers in a single Pod is an advanced use case.

Pods share networking and storage resources and is meant to run a single "instance" of the application. It is NOT recommended to create individual pods, instead you create `replicas`, your application runs in a `replicaset` which is managed by a controller (deployment) which manages the Pod lifecycle.

## Private clusters
Private clusters give you the ability to isolate nodes from having inbound and outbound connectivity to the public internet. This isolation is achieved as the nodes have internal IP addresses only. If you need or want to provide outbound internet access for private nodes you can leverage Cloud NAT or managed your own NAT Gateway.

The master is peered to your VPC network containing the cluster nodes.

Even though the node IP addresses are private, external clients can reach [Services](https://cloud.google.com/kubernetes-engine/docs/concepts/service) in your cluster. For example, you can create a Service of type LoadBalancer, and external clients can call the IP address of the load balancer. Or you can create a Service of type NodePort and then create an Ingress. GKE uses information in the Service and the Ingress to configure an [HTTP(S) load balancer](https://cloud.google.com/load-balancing/docs/https). External clients can then call the external IP address of the HTTP(S) load balancer.

![Private Clusters](images/private-cluster.svg)

Private Google Access is enabled by default for Private Clusters.

## GKE Security
* Use _authorized networks_ to whitelist specific CIDR ranges and allow IP addresses in those ranges to access the _cluster master_.
* alternatively create _private clusters_.
* Use shielded GKE nodes `--enable-shielded-nodes` at cluster creation or update. Shielded GKE nodes should be configured with secure boot, `--shielded-secure-boot` at cluster creation.
* Use hardened node image with `containerd` runtime, which is the core runtime component of Dockerand has been designed to deliver core container functionality for the Kubernetes Container Runtime Interface (CRI). It is significantly less complex than the full Docker daemon, and therefore has a smaller attack surface.
  * use the `glcoud` flag `--image-type=cos_containerd` at cluster creation or upgrade time.
* Use _Workload Identity_ for access Google Services from applications running in GKE.
  * [k8s service account](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/) is configured to act as a Google service account, which would authenticate as the GCP account when accessing GCP Apis.

```
gcloud iam service-accounts add-iam-policy-binding \
  --role roles/iam.workloadIdentityUser \
  --member "serviceAccount:project-id.svc.id.goog[default/default]" \
  gsa-name@project-id.iam.gserviceaccount.com
```

* Role-based Access Control (RBAC) is a built-in mechanism which allows you to configure fine-grained access and permission to interact with K8S objects in the cluster.
  * `cluster-admin` grants full permissions in the cluster to a user

**Workload Identity**

Enabling:

```
gcloud container clusters create CLUSTER_NAME \
    --region=COMPUTE_REGION \
    --workload-pool=PROJECT_ID.svc.id.goog
```

Creating a new node pool:

```
gcloud container node-pools create NODEPOOL_NAME \
    --cluster=CLUSTER_NAME \
    --workload-metadata=GKE_METADATA
```

The `--workload-metadata=GKE_METADATA` flag configures the node pool to use the GKE metadata server. We recommend that you include the flag so that node pool creation fails if _Workload Identity_ is not enabled on the cluster.

Configure applicaitons to use Workload Identity:

1. Create k8s service account
```
kubectl create serviceaccount KSA_NAME \
    --namespace NAMESPACE
```
2. Create GCP Service Account
```
gcloud iam service-accounts create GSA_NAME \
    --project=GSA_PROJECT
```
3. Add IAM policy binding
```
gcloud projects add-iam-policy-binding PROJECT_ID \
    --member "serviceAccount:GSA_NAME@GSA_PROJECT.iam.gserviceaccount.com" \
    --role "ROLE_NAME"
```
4. Allow k8s service account to impersonate the IAM service account
```
gcloud iam service-accounts add-iam-policy-binding GSA_NAME@GSA_PROJECT.iam.gserviceaccount.com \
    --role roles/iam.workloadIdentityUser \
    --member "serviceAccount:PROJECT_ID.svc.id.goog[NAMESPACE/KSA_NAME]"
```
5. Annotate the k8s service account with the email of the IAM service account
```
kubectl annotate serviceaccount KSA_NAME \
    --namespace NAMESPACE \
    iam.gke.io/gcp-service-account=GSA_NAME@GSA_PROJECT.iam.gserviceaccount.com
```
6. Update Pod spec(s) to schedule workloads on nodes that use Workload Identity:
```
spec:
  serviceAccountName: KSA_NAME
  nodeSelector:
    iam.gke.io/gke-metadata-server-enabled: "true"
```
Full example:

```
apiVersion: v1
kind: Pod
metadata:
  name: workload-identity-test
  namespace: NAMESPACE
spec:
  containers:
  - image: google/cloud-sdk:slim
    name: workload-identity-test
    command: ["sleep","infinity"]
  serviceAccountName: KSA_NAME
  nodeSelector:
    iam.gke.io/gke-metadata-server-enabled: "true"
```
7. Update cluster configuration
```
kubectl apply -f DEPLOYMENT_FILE
```


**Provide a user with full admin**

```
kubectl create clusterrolebinding cluster-admin-binding \
  --clusterrole cluster-admin \
  --user [user-account]
```

These can be defined as objects via yaml files and provisions in the cluster also.

* `ClusterRole` or `Role`:
  * set of resource types and operations that can be assigned to a user or group of users in a cluster (ClusterRole) or Namespace (Role) but does not specify the user or group of users.
  * _ClusterRole_ are scoped to the cluster you can also use them to grant access to:
    - cluster-scoped resources (like nodes)
    - non-resource endpoints (like /healthz)
    - namespaced resources (like Pods), across all namespaces
* `ClusterRoleBinding` or `RoleBinding`:
  * assignes ClusterRole or Role to a user or group of users.

Samples:
```
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: accounting
  name: pod-reader
rules:
- apiGroups: [""] # "" indicates the core API group
  resources: ["pods"]
  verbs: ["get", "watch", "list"]
```
```
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: pod-reader-binding
  namespace: accounting
subjects:
# Google Cloud user account
- kind: User
  name: janedoe@example.com
# Kubernetes service account
- kind: ServiceAccount
  name: johndoe
# IAM service account
- kind: User
  name: test-account@test-project-123456.google.com.iam.gserviceaccount.com
# G Suite Google Group
- kind: Group
  name: accounting-group@example.com
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```
```
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  # "namespace" omitted since ClusterRoles are not namespaced
  name: secret-reader
rules:
- apiGroups: [""]
  #
  # at the HTTP level, the name of the resource for accessing Secret
  # objects is "secrets"
  resources: ["secrets"]
  verbs: ["get", "watch", "list"]
```
```
apiVersion: rbac.authorization.k8s.io/v1
# This cluster role binding allows anyone in the "manager" group to read secrets in any namespace.
kind: ClusterRoleBinding
metadata:
  name: read-secrets-global
subjects:
- kind: Group
  name: manager # Name is case sensitive
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: secret-reader
  apiGroup: rbac.authorization.k8s.io
```

**RBAC Authorization**

https://kubernetes.io/docs/reference/access-authn-authz/rbac/

To enable RBAC run `kube-apiserver --authorization-mode=Example,RBAC --other-options --more-options`

**IAM Permissions**

* `roles/container.admin`
  - K8S Engine Admin
  - Access to full management of clusters and k8s API Objects
* `roles/container.clusterAdmin`
  - k8s engine cluster admin
  - Access to management of clusters
* `roles/container.clusterView`
  - k8s cluster engine Viewer
  - get/list of GKE clusters
* `roles/container.developer`
  - k8s engine developer
  - access to k8s API objects in clusters
* `roles/container.hostServiceAgentUser`
  - k8s engine hosrt service agent user
  - Allows the k8s engine service account in the host project to configure shared network resources for cluster management. Also gives access to inspect the firewall rules in the host project.
  - **ONLY USED in Shared VPC clusters**
* `roles/container.nodeServiceAccount`
  - k8s engine node service account
  - Least priviledge role to use as the service account for GKE nodes
* `roles/container.viewer`
  - k8s engine Viewer
  - Provides read-only access to resources within GKE clusters, such as nodes, pods, and GKE api Objects
*

**Application-layer Secrets Encryption**
By defulat GKE encrypts content stored at rest, including Secrets.

_Application-layer Secrets Encryption_ is an additional layer of security for sensitive data, such as Secrets, stored in [etcd](https://kubernetes.io/docs/concepts/overview/components/#etcd). To use this feature a Cloud KMS key and GKE service account **MUST** be created. The key must be in the same location as the cluster in order to decrease latency.

GKE will encrypt secrets locally using the [AES-CBC](https://tools.ietf.org/html/rfc3602) provider, using local data encryption keys (DEKs) and the DEKs are encrypted with a key encryption key (KEK) that is managed in Cloud KMS.

This is referred to as _Envelope Encryption_, which provides the following benefits:

* KEKs can be rotated without having to re-encrypt secrets
* Secrets stored in Kubernetes can rely on an external root trust, [Hardware Security Module](https://en.wikipedia.org/wiki/Hardware_security_module).

![Envelope Encryption](images/envelope_encryption_store.svg)

When a secret is added:

* Kubernetes API server generates a DEK for the secret, using a random number generator
* Uses the DEK locally to encrypt the secret
* The [KMS plugin](https://github.com/GoogleCloudPlatform/k8s-cloudkms-plugin) sends the DEK to Cloud KMS for encryption, using the GKE Service Account to authenticate.
* Cloud KMS encrypts the DEK and sends it back
* K8S api server saves the encrypted secret and encryted DEK, the plaintext DEK is not saved.

**NOTE**
_When a key is destroyed in Cloud KMS any Secrets, that were encrypted by it, will no longer be available._

**GKE Sandbox**
Provides and extra layer of security to prevent untrusted code from affecting the host kernel on you worker nodes. This is done by leveraging [gVisor](https://gvisor.dev/).

gVisor is a userspace re-implementation of the Linux kernel API that does not need elevated privileges. In conjunction with a container runtime such as `containerd`, the userspace kernel re-implements the majority of system calls and services them on behalf of the host kernel. From the container's point of view, gVisor is nearly transparent, and does not require any changes to the containerized application.

When enabled on a node pool, a sandbox is created for each Pod running on a node in that node pool.

GKE sandboxes are typically a good fit for:
* Untrusted or 3rd party applications using runtimes such as Rust, Java, Python, Node.js, or Golang
* Web server FE, caches or proxies
* Apps processing external media or data using CPUs
* ML workloads
* CPU or RAM intensive workloads

It recommended to specify resource limits for containers in sandboxes.

GKE Sandbox cannot be enabled on the default node pool. Node pool cannot use e2-micro, e2-small and e2-medium machine types.

Hyper-threading is disbaled by default for Sandboxed node pools to prevent side channel vulnerabilities that take advantange of core state shared between hyper-threads. To enable this at node pool creation time add a node lable `cloud.google.com/gke-smt-disabled=false:`, then deploy a `DaemonSet` to the node pool using:

```
kubectl create -f \
    https://raw.githubusercontent.com/GoogleCloudPlatform/k8s-node-tools/master/disable-smt/gke/enable-smt.yaml
```
The DaemonSet will only run on nodes with the `cloud.google.com/gke-smt-disabled=false` label. It will enable Hyper-Threading and then reboot the node.

**GKE Network Security**
Limit Pod-to-Pod communication by using [network policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/) which will lock down ingress and egress to and from pod within a namespace. Once a policy if configured, all traffic that does not match the configured labels is dropped.

Sample Network policy:
```
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: hello-allow-from-foo
spec:
  policyTypes:
  - Ingress
  podSelector:
    matchLabels:
      app: hello
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: foo

```

Use the `--enable-network-policy` flag at cluster creation time to enforce network policies. If the flag is omited any network policy configure will be ignored.

[Network Policy Tutorial](https://cloud.google.com/kubernetes-engine/docs/tutorials/network-policy)

Another concept is to filtering load balanced traffic. To accomplish this a [network load balancer](https://cloud.google.com/compute/docs/load-balancing/network) must be created as a k8s Service of type `LoadBalancer` which matches you Pod's labels. When this service is created, and external-facing IP is configured that maps to ports on you k8s pods.

By specifying a list of CIDR ranges in the `loadBalancerSourceRanges` in the Service deployment yaml will whitelist those ips as authorized access to the service. If no ips are specified all address are allowed.

Using a [kube-proxy](https://kubernetes.io/docs/reference/generated/kube-proxy/), you can filter traffic a the node level.

**Securing Workloads**
Kubernetes allows users to quickly provision, scale, and update container-based workloads. This section describes tactics that administrators and users can employ to limit the effect a running container can have on other containers in the same cluster, the nodes where containers can run, and the Google Cloud services enabled in users' projects.

Use the [Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) to set security-related options on both Pods and Containers, such as:

* User and group to run as
* Available Linux capabilities
* Ability to escalate privileges

Sample Security Context:

```
apiVersion: v1
kind: Pod
metadata:
  name: security-context-demo
spec:
  securityContext:
    runAsUser: 1000
    runAsGroup: 3000
    fsGroup: 2000
    fsGroupChangePolicy: "OnRootMismatch"
  volumes:
  - name: sec-ctx-vol
    emptyDir: {}
  containers:
  - name: sec-ctx-demo
    image: busybox
    command: [ "sh", "-c", "sleep 1h" ]
    volumeMounts:
    - name: sec-ctx-vol
      mountPath: /data/demo
    securityContext:
      allowPrivilegeEscalation: false
```

In the configuration file, the `runAsUser` field specifies that for any Containers in the Pod, all processes run with user ID 1000. The `runAsGroup` field specifies the primary group ID of 3000 for all processes within any containers of the Pod. If this field is omitted, the primary group ID of the containers will be root(0). Any files created will also be owned by user 1000 and group 3000 when `runAsGroup` is specified. Since _fsGroup_ field is specified, all processes of the container are also part of the supplementary group ID 2000. The owner for volume /data/demo and any files created in that volume will be Group ID 2000.

`fsGroupChangePolicy` - _fsGroupChangePolicy_ defines behavior for changing ownership and permission of the mounted volume before being exposed inside a Pod. This field only applies to volume types that support `fsGroup` controlled ownership and permissions. This field has two possible values:

* _OnRootMismatch_: Only change permissions and ownership if permission and ownership of root directory does not match with expected permissions of the volume. This could help shorten the time it takes to change ownership and permission of a volume.
* _Always_: Always change permission and ownership of the volume when volume is mounted.


**NOTE THAT THE FOLLOWING HAS BEEN DEPRECATED IN k8s v1.21 AND WILL BE REMOVED in v1.25**
To change these settings at the cluster level a `PodSecurityPolicy` needs to be implemented.

A PodSecurityPolicy is an admission controller resource that is created which validates requests to create and update Pods on the cluster. The PodSecurityPolicy defines a set of conditions that Pods must meet to be accepted by the cluster; when a request to create or update a Pod does not meet the conditions in the PodSecurityPolicy, that request is rejected and an error is returned.


Sample PodSecurity Policy Spec:

```
apiVersion: policy/v1beta1
kind: PodSecurityPolicy
metadata:
  name: my-psp
spec:
  privileged: false  # Prevents creation of privileged Pods
  seLinux:
    rule: RunAsAny
  supplementalGroups:
    rule: RunAsAny
  runAsUser:
    rule: RunAsAny
  fsGroup:
    rule: RunAsAny
  volumes:
  - '*'
```

To enable the use of PodSecurityPolicy use the `--enable-pod-security-policy` flag at cluster creation or update.

The GKE node operating systems, both Container-Optimized OS and Ubuntu, [apply the default Docker AppArmor security policies](https://cloud.google.com/container-optimized-os/docs/how-to/secure-apparmor#using_the_default_docker_apparmor_security_profile) to all containers started by Kubernetes.


**END OF DEPRECATED AREA**

**This feature is currently is beta for Kubernetes v1.4**

**AppArmour**
AppArmour is a linux kernel security module that supplements the standard linux user and group based permissions to confine programs to a liimited set of resources. AppArmour can be configured for any application to reduce its potential attack surface and provide greater in-depth defence.

Its configured through profiles tuned to allow the access needed by a specific program or container, such as Linux capabilities, network access, file permissions, etc. Each profile can be run in either _enforcing_ mode, which blocks access to disallowed resources, or _complain_ mode, which only reports violations.

AppArmor can help you to run a more secure deployment by restricting what containers are allowed to do, and/or provide better auditing through system logs. However, it is important to keep in mind that AppArmor is not a silver bullet and can only do so much to protect against exploits in your application code. It is important to provide good, restrictive profiles, and harden your applications and cluster from other angles as well.

Ubuntu and SUSE distributions of Linux AppArmour is enbaled by default

_AppArmour_ profiles are specified per container. To specify the AppArmour profile to run a Pod container with , add an annotation to the Pod's metadata:

`container.apparmor.security.beta.kubernetes.io/<container_name>: <profile_ref>`

Where ``<container_name>`` is the name of the container to apply the profile to, and ``<profile_ref>`` specifies the profile to apply. The profile_ref can be one of:

* `runtime/default` to apply the runtime's default profile
* `localhost/<profile_name>` to apply the profile loaded on the host with the name `<profile_name>``
* `unconfined`G to indicate that no profiles will be loaded

**Binary Authorization**
Binary Authorization is a service on Google Cloud that provides software supply-chain security for applications that run in the cloud.

It works with images that you deploy to GKE from Container Registry or another container image registry. With Binary Authorization, you can ensure that internal processes that safeguard the quality and integrity of your software have successfully completed before an application is deployed to your production environment.

To enable this service on a project run the following command:

```
gcloud services enable \
    container.googleapis.com \
    containeranalysis.googleapis.com \
    binaryauthorization.googleapis.com
```

To create a cluster with `Binary Authorization` enabled run:

```
gcloud container clusters create \
    --enable-binauthz \
    --zone [ZONE] \
    [CLUSTER_NAME]
```

A _policy_ in Binary Authorization is a set of rules that govern the deployment of container images to Google Kubernetes Engine (GKE). A policy has the following parts:

* Deployment rules
* List of exempt images

Each GCP project can have exactly ONE policy.

Sample Policy:

```
admissionWhitelistPatterns:
- namePattern: gcr.io/google_containers/*
- namePattern: gcr.io/google-containers/*
- namePattern: k8s.gcr.io/*
- namePattern: gke.gcr.io/*
- namePattern: gcr.io/stackdriver-agents/*
globalPolicyEvaluationMode: ENABLE
defaultAdmissionRule:
  evaluationMode: ALWAYS_ALLOW
  enforcementMode: ENFORCED_BLOCK_AND_AUDIT_LOG
name: projects/PROJECT_ID/policy
```

An _attestation_ is a digital document that certifies that GKE is allowed to deploy the container image.

An attestation is created after a container image is built. Each such container has a globally unique digest. A signer signs the container image digest using a private key from a key pair and uses the signature to create the attestation. At deploy time, the Binary Authorization enforcer uses the attestor's public key to verify the signature in the attestation. Typically one attestor corresponds to exactly one signer.

To enable attestations in Binary Authorization, your policy's `enforcementMode` is set to `REQUIRE_ATTESTATION`.

Creating attestations:

```
gcloud alpha container binauthz attestations create \
    --project="${ATTESTATION_PROJECT_ID}" \
    --artifact-url="${IMAGE_TO_ATTEST}" \
    --attestor="projects/${ATTESTOR_PROJECT_ID}/attestors/${ATTESTOR_NAME}" \
    --signature-file=/tmp/ec_signature \
    --public-key-id="${PUBLIC_KEY_ID}" \
    --validate
```

Using Cloud KMS:

```
gcloud beta container binauthz attestations sign-and-create \
    --project="${ATTESTATION_PROJECT_ID}" \
    --artifact-url="${IMAGE_TO_ATTEST}" \
    --attestor="${ATTESTOR_NAME}" \
    --attestor-project="${ATTESTOR_PROJECT_ID}" \
    --keyversion-project="${KMS_KEY_PROJECT_ID}" \
    --keyversion-location="${KMS_KEY_LOCATION}" \
    --keyversion-keyring="${KMS_KEYRING_NAME}" \
    --keyversion-key="${KMS_KEY_NAME}" \
    --keyversion="${KMS_KEY_VERSION}"
```
## Logging

GKE integrates with Cloud Audit Logging and these logs can be viewed in Cloud Logging or in GCP Activity console
## Container Best Practices
A full list of best practices can be found [here](https://cloud.google.com/blog/products/gcp/7-best-practices-for-building-containers).

Highlights:

* Single App Per Container
  * Ex (Apache/MySQL/PHP stack):
    * Each should be their own container
* Properly handle PID 1, signal handling and zombie processes
  * Handle SIGTERM/SIGKILL in you application
  * Lauch process using `CMD` or `ENTRYPOINT`
    * If additional preparation is needed before launching your process, launch a shell script using the `exec` command.
* Remove unnecessary tools
  * ex (netcat, tracing or debugging tools)
* Avoid running as root
  * ex disable use of sudo
* Launch Containers is RO model `--read-only` docker command flag or `readOnlyRootFilesystem` option in Kubernetes.
  * This can also be enforced using a [`PodSecurityPolicy`](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems)
* Build the smallest image as possible
  * [Reduce clutter in your image](https://cloud.google.com/solutions/best-practices-for-building-containers#reduce_the_amount_of_clutter_in_your_image).
* Use vulnerability scanning in Container Registry
