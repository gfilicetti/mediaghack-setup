NETWORK=${1:-"default"}
REGION=${2:-"us-central1"}
RANGE=${3:-"10.1.0.0/16"}
PROJECT=${4:-`gcloud config get-value project`}

gcloud compute networks create default --subnet-mode=custom
gcloud compute networks subnets create us-central1 --range=$RANGE --stack-type=IPV4_ONLY --network=$NETWORK --region=$REGION
