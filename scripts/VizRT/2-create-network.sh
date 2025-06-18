NETWORK=${1:-"default"}
REGION=${2:-"us-central1"}
RANGE=${3:-"10.1.0.0/16"}
PROJECT=${4:-`gcloud config get-value project`}

gcloud compute networks create default --subnet-mode=custom --project=$PROJECT 
gcloud compute networks subnets create us-central1 --range=$RANGE --stack-type=IPV4_ONLY --network=$NETWORK --region=$REGION --project=$PROJECT 
gcloud compute firewall-rules create allow-remotes --direction=INGRESS --priority=1000 --network=$NETWORK --action=ALLOW --rules=tcp:22,tcp:80,tcp:443,tcp:3389 --source-ranges=0.0.0.0/0 --project=$PROJECT 