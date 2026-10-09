#!/bin/bash

set -e

REGION="ap-south-1"
ACCOUNT_ID="563675987277"
REPO_NAME="django-app"
IMAGE_TAG="latest"
ECR_URI="563675987277.dkr.ecr.ap-south-1.amazonaws.com"

echo "Building Docker Image...."
docker build -t $REPO_NAME:$IMAGE_TAG . 

echo "Authentication with AWS ECR..."
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ECR_URI

echo "Tagging image for ECR"
docker tag $REPO_NAME:$IMAGE_TAG $ECR_URI/$REPO_NAME:$IMAGE_TAG

echo "Pushing to ECR...."
docker push $ECR_URI/$REPO_NAME:$IMAGE_TAG

echo "Deployment to ECR successfull"
