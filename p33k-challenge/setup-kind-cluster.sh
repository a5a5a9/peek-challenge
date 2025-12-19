#!/bin/bash


set -e


kind create cluster --name voting-platform --config kind-config.yaml || echo "Cluster already exists, skipping creation..."


docker rm -f kind-registry registry 2>/dev/null || echo "No old registry containers found, skipping..."

echo "Kind cluster 'voting-platform' is ready."
echo "Now use the 'build-and-load.sh' script to push your images."
