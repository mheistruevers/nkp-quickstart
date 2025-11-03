source ./nkp-env-bundle

NKP_VERSION=$(nkp version -o=json |jq -r '.nkp.gitVersion')

nkp create cluster nutanix -c $CLUSTER_NAME \
    ${CLUSTER_HOSTNAME:+--cluster-hostname "$CLUSTER_HOSTNAME"} \
    --endpoint https://$NUTANIX_ENDPOINT:$NUTANIX_PORT \
    --insecure \
    --kubernetes-service-load-balancer-ip-range $LB_IP_RANGE \
    --control-plane-endpoint-ip $CONTROL_PLANE_ENDPOINT_IP \
    --control-plane-vm-image $NUTANIX_MACHINE_TEMPLATE_IMAGE_NAME \
    --control-plane-prism-element-cluster $NUTANIX_PRISM_ELEMENT_CLUSTER_NAME \
    --control-plane-subnets $NUTANIX_SUBNET_NAME \
    --control-plane-replicas $CONTROL_PLANE_REPLICAS \
    --worker-vm-image $NUTANIX_MACHINE_TEMPLATE_IMAGE_NAME \
    --worker-prism-element-cluster $NUTANIX_PRISM_ELEMENT_CLUSTER_NAME \
    --worker-subnets $NUTANIX_SUBNET_NAME \
    --worker-replicas $WORKER_NODES_REPLICAS \
    --csi-storage-container $NUTANIX_STORAGE_CONTAINER_NAME \
    --csi-hypervisor-attached-volumes=$CSI_HYPERVISOR_ATTACHED \
    ${SSH_PUBLIC_KEY_FILE:+--ssh-public-key-file "$SSH_PUBLIC_KEY_FILE"} \
    ${CP_CATEGORIES:+--control-plane-pc-categories "$CP_CATEGORIES"} \
    ${WORKER_CATEGORIES:+--worker-pc-categories "$WORKER_CATEGORIES"} \
    --bundle ${KONVOYIMAGES},${KOMMANDERIMAGES} \
    --self-managed \
    --dry-run
