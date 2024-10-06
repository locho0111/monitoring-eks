#!/bin/bash
eksctl create nodegroup \
  --cluster my-eks-cluster \
  --region us-east-1 \
  --name "myeks-ng-public1" \
  --node-type "t2.medium" \
  --nodes 2 \
  --nodes-min 2 \
  --nodes-max 4 \
  --node-volume-size 20 \
  --ssh-access \
  --ssh-public-key "devops-key" \
  --managed \
  --asg-access \
  --external-dns-access \
  --full-ecr-access \
  --appmesh-access \
  --alb-ingress-access
