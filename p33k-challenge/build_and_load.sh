#!/usr/bin/env bash
set -e

CLUSTER_NAME="voting-platform"
IMAGE_UI="votes-ui:latest"
IMAGE_API="votes-api:latest"

VOTES_UI_PATH="../devops-challenge/votes-ui"
VOTES_API_PATH="../devops-challenge/votes-api"

echo "Building images..."
docker build -t $IMAGE_UI $VOTES_UI_PATH
docker build -t $IMAGE_API $VOTES_API_PATH

echo "Loading images into Kind cluster: $CLUSTER_NAME..."
kind load docker-image $IMAGE_UI --name $CLUSTER_NAME
kind load docker-image $IMAGE_API --name $CLUSTER_NAME

echo "Success! Images are now inside the Kind nodes."
echo "You can now install Crossplane"

