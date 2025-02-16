#!/bin/bash

# Variables
DOCKER_HUB_USERNAME="manjunathdc"
IMAGE_NAME="devops-app"
TAG="dev"
SERVER_IP="54.202.75.111"
SSH_KEY="oregon-test.pem"

# SSH into the server and deploy the application
echo "Deploying application to server..."
ssh -i $SSH_KEY ubuntu@$SERVER_IP << EOF
    sudo apt update
    sudo apt upgrade
    # Pull the latest Docker image
    echo "Pulling the latest Docker image..."
    docker pull $DOCKER_HUB_USERNAME/$IMAGE_NAME:$TAG

    # Stop and remove the existing container if it exists
    echo "Stopping and removing existing container..."
    docker stop $IMAGE_NAME || true
    docker rm $IMAGE_NAME || true

    # Run the new container
    echo "Starting new container..."
    docker run -d -p 80:80 --name $IMAGE_NAME $DOCKER_HUB_USERNAME/$IMAGE_NAME:$TAG

    echo "Deployment completed successfully."
EOF