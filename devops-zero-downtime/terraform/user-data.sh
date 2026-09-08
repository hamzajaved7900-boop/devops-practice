#!/bin/bash
yum update -y
yum install -y docker
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user

# Authenticate Docker with AWS ECR
REGION="us-east-1"
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin "$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com"

# Pull and run application container
IMAGE_URI="$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/production-api:latest"
docker pull $IMAGE_URI || true
docker run -d --restart=always -p 80:3000 -e APP_VERSION="initial" $IMAGE_URI || true