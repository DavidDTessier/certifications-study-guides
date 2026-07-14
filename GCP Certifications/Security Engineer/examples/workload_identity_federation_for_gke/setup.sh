#!/bin/sh

## Set up variables

export PROJECT_ID=""
export ZONE=us-east1-b

# Enable applicable APIs

gcloud services enable compute.googleapis.com container.googleapis.com

# Create the GKE cluster
gcloud container clusters create demo-gke-cluster --zone $ZONE --num-nodes 1 --project $PROJECT_ID
gcloud container clusters get-credentials demo-gke-cluster --zone $ZONE --project $PROJECT_ID

##
## DO NOT USE IN PRODUCTION!
## THIS IS ONLY MEANT TO ILLUSTRATE 
## THE NEED FOR WORKLOAD IDENTITY FEDERATION
##

# Create the service account in GCP
gcloud iam service-accounts create sa-with-key \
    --description="Service Account with Key Export"

# Create and download a service account key file in json format
gcloud iam service-accounts keys create ./sa-with-key-export.json \
    --iam-account=sa-with-key@$PROJECT_ID.iam.gserviceaccount.com

# Create a k8s secret for the key
kubectl create secret generic sa-key --from-file=key.json=./sa-with-key-export.json

# Create a pod with the secret mounted
kubectl apply -f - <<EOF 
apiVersion: v1
kind: Pod
metadata:
  name: sa-key-mount
spec:
  containers:
  - image: google/cloud-sdk:slim
    name: workload-identity-test
    command: ["sleep","infinity"]
    volumeMounts:
    - name: sa-key
      mountPath: "/var/secrets/google"
      readOnly: true
    env:
    - name: GOOGLE_APPLICATION_CREDENTIALS
      value: /var/secrets/google/key.json
  volumes:
  - name: sa-key
    secret:
      secretName: sa-key

EOF

