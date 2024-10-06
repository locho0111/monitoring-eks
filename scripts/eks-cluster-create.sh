#!/bin/bash

# 1-CREATE EKS CLUSTER
VARIABLES=('EKS_CLUSTER_NAME' 'EKS_CLUSTER_REGION' 'EKS_CLUSTER_ZONES')

for VAR in "${VARIABLES[@]}"; do
  if [ -z "${!VAR}" ]; then
    echo "$VAR is unset or set to the empty string"
    exit 1
  else
    echo "$VAR = ${!VAR}"
  fi
done

if [ "$(eksctl get cluster -o json | jq -r '.[].Name' | grep "$EKS_CLUSTER_NAME")" = "$EKS_CLUSTER_NAME" ]; then
  echo "EKS cluster $EKS_CLUSTER_NAME already exists"
else
  eksctl create cluster --name="$EKS_CLUSTER_NAME" \
    --region="$EKS_CLUSTER_REGION" \
    --zones="$EKS_CLUSTER_ZONES" \
    --without-nodegroup
fi

# 2-CREATE AND ASSOCIATE IAM OIDC PROVIDER FOR EKS CLUSTER
eksctl utils associate-iam-oidc-provider \
  --region "$EKS_CLUSTER_REGION" \
  --cluster "$EKS_CLUSTER_NAME" \
  --approve
