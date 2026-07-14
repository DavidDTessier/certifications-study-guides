# Create first vpc
gcloud compute networks create vpc1 --subnet-mode=custom

# Create two subnets in VPC1
gcloud compute networks subnets create subnet1a --network=vpc1 --region=us-east1 --range=10.240.1.0/28
gcloud compute networks subnets create subnet1b --network=vpc1 --region=us-central1 --range=10.240.2.0/28

gcloud compute firewall-rules create allow-ssh-vpc1 --network vpc1 --allow tcp:22,tcp:3389,icmp


# Create second vpc
gcloud compute networks create vpc2 --subnet-mode=custom

# Create two subnets in VPC1
gcloud compute networks subnets create subnet2a --network=vpc2 --region=us-east1 --range=10.240.3.0/28
gcloud compute networks subnets create subnet2b --network=vpc2 --region=us-central1 --range=10.240.4.0/28

gcloud compute firewall-rules create allow-ssh-vpc2 --network vpc2 --allow tcp:22,tcp:3389,icmp


## Create the Peer between VPC1 and VPC2
gcloud compute networks peerings create vpc1-vpc2 --network=vpc1 --peer-network=vpc2
gcloud compute networks peerings create vpc2-vpc1 --network=vpc2 --peer-network=vpc1

# Create GCE Instances to test peering

gcloud compute instances create vm1 --network=vpc1 --subnet=subnet1a --zone=us-east1-c
gcloud compute instances create vm2 --network=vpc2 --subnet=subnet2b --zone=us-central1-c

## Uncomment to ssh into either VM to test
#gcloud compute ssh --zone "us-east1-c" "vm1" --project "<PROJECT>"
# Run the next command
## ping -c 5 <VM2_INTERNAL_IP>

# Delete Resources

gcloud compute networks peerings delete vpc1-vpc2 --network=vpc1
gcloud compute networks peerings delete vpc2-vpc1 --network=vpc2

gcloud compute instances delete vm1 --network=vpc1 --zone=us-east1-c
gcloud compute instances delete vm2 --network=vpc2 ---zone=us-central1-c

gcloud compute firewall-rules delete allow-ssh-vpc2
gcloud compute firewall-rules delete allow-ssh-vpc1

gcloud compute networks subnets delete subnet2a --region=us-east1
gcloud compute networks subnets delete subnet2b --region=us-central1 

gcloud compute networks subnets delete subnet1a --region=us-east1
gcloud compute networks subnets delete subnet1b --region=us-central1

gcloud compute networks delete vpc1
gcloud compute networks delete vpc2