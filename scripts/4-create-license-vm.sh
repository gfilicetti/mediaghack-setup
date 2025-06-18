gcloud compute addresses create viz-tricaster-4-ip --region=us-central1
gcloud compute addresses describe viz-tricaster-4-ip --region=us-central1 --format="get(address)"

gcloud compute instances create viz-tricaster-4 \
	--zone=us-central1-a --machine-type=g2-standard-16 \
	--network-interface=address=35.239.208.200,network-tier=PREMIUM,nic-type=GVNIC,stack-type=IPV4_ONLY,subnet=us-central1 \
	--accelerator=count=1,type=nvidia-l4 \
	--tags=http-server,https-server,lb-health-check \
	--create-disk=auto-delete=yes,boot=yes,device-name=viz-tricaster-1,image=projects/windows-cloud/global/images/windows-server-2022-dc-v20250613,mode=rw,size=50,type=pd-balanced \
	--create-disk=auto-delete=yes,device-name=disk-1,mode=rw,name=viz-tricaster-4-disk-1,size=70,type=pd-balanced \
	--create-disk=auto-delete=yes,device-name=disk-2,mode=rw,name=viz-tricaster-4-disk-2,size=200,type=pd-balanced \
	--create-disk=auto-delete=yes,device-name=disk-3,mode=rw,name=viz-tricaster-4-disk-3,size=500,type=pd-ssd \
	--shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring \
	--metadata=enable-osconfig=TRUE,enable-oslogin=true \
	--maintenance-policy=TERMINATE --provisioning-model=STANDARD