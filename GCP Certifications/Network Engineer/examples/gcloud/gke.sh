GCP_PROJECT=gke-demo-447701
ZONE=us-central1-a
REGION=us-central1

# Clone this repo git clone https://github.com/GoogleCloudPlatform/kubernetes-engine-samples

## Enable the apis
gcloud services enable container.googleapis.com --project $GCP_PROJECT
gcloud services enable compute.googleapis.com --project $GCP_PROJECT

# Create first vpc
gcloud compute networks create gke-vpc-demo --subnet-mode=custom

# Create two subnets in VPC1
gcloud compute networks subnets create subnet1a --network=gke-vpc-demo --region=$REGION --range=10.2.240.0/28  --secondary-range=pod-cidr-app=10.240.2.0/24,demo-services=192.240.1.0/24

# Create GKE cluster
## With the default settings for standard clusters, GKE requires a /24 mask (256 IP addresses allocated for pods) for each node and three worker nodes per cluster.
## See https://cloud.google.com/kubernetes-engine/docs/how-to/flexible-pod-cidr#cidr_ranges_for_clusters
## Our has allocated a /24 mask for pods (pod-cidr-app in Figure 3-110), that is, 256 IP addresses.
## However, in the gcloud command, we have requested the number of nodes to be two without specifying a maximum number of pods per node, that is, the default /24 mask will be used for each of the two nodes.
gcloud container clusters create demo-cluster --zone=$ZONE --machine-type=e2-micro --enable-ip-access --enable-network-policy --network=gke-vpc-demo --subnetwork=subnet1a --num-nodes=2 #--max-pods-per-node=10 --cluster-secondary-range-name=pod-cidr-app --services-secondary-range-name=demo-services

## Once cluster is created update to enable network policies



