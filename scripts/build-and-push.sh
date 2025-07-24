#!/bin/bash

# Build and push Docker image to ECR

set -e

# Variables
AWS_REGION=${AWS_REGION:-us-east-1}
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
IMAGE_NAME=${PROJECT_NAME:-3tier-ecs-app}
IMAGE_TAG=${IMAGE_TAG:-latest}

# ECR repository URL
ECR_URI="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$IMAGE_NAME"

echo "Building and pushing Docker image..."
echo "ECR URI: $ECR_URI"

# Create ECR repository if it doesn't exist
aws ecr describe-repositories --repository-names $IMAGE_NAME --region $AWS_REGION || \
aws ecr create-repository --repository-name $IMAGE_NAME --region $AWS_REGION

# Get ECR login token
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_URI

# Build Docker image
docker build -t $IMAGE_NAME:$IMAGE_TAG ./app/

# Tag image for ECR
docker tag $IMAGE_NAME:$IMAGE_TAG $ECR_URI:$IMAGE_TAG

# Push image to ECR
docker push $ECR_URI:$IMAGE_TAG

echo "Image pushed successfully: $ECR_URI:$IMAGE_TAG"
echo "Update your terraform.tfvars with:"
echo "app_image = \"$ECR_URI:$IMAGE_TAG\""
