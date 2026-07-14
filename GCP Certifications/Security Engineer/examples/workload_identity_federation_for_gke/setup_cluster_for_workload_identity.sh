#!/bin/sh

## Set up variables

export PROJECT_ID="adroit-anthem-417714"
export ZONE=us-east1-b

# update clusters
gcloud container clusters update demo-gke-cluster \
    --zone=$ZONE \
    --workload-pool=$PROJECT_ID.svc.id.goog

gcloud container node-pools update default-pool \
    --cluster=demo-gke-cluster \
    --zone=$ZONE \
    --workload-metadata=GKE_METADATA




kubectl create serviceaccount workload-id-demo-k8s-sa

gcloud iam service-accounts create workload-id-demo-gcp-sa --description "SA for the GKE Demo Workload"

gcloud iam service-accounts add-iam-policy-binding workload-id-demo-gcp-sa@$PROJECT_ID.iam.gserviceaccount.com \
    --role roles/iam.workloadIdentityUser \
    --member "serviceAccount:$PROJECT_ID.svc.id.goog[default/workload-id-demo-k8s-sa]"

kubectl annotate serviceaccount workload-id-demo-k8s-sa \
    --namespace default \
    iam.gke.io/gcp-service-account=workload-id-demo-gcp-sa@$PROJECT_ID.iam.gserviceaccount.com

kubectl apply -f - <<EOF 
apiVersion: v1
kind: Pod
metadata:
  name: workload-identity
  namespace: default
spec:
  containers:
  - image: google/cloud-sdk:slim
    name: workload-identity-test
    command: ["sleep","infinity"]
  serviceAccountName: workload-id-demo-k8s-sa
  nodeSelector:
    iam.gke.io/gke-metadata-server-enabled: "true"
EOF


See here: https://medium.com/google-cloud/whoami-the-quest-of-understanding-gke-workload-identity-federation-e951e5e4a03f