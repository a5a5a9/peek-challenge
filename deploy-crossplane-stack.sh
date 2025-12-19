#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Starting Crossplane Installation..."

# 1. Install Crossplane via Helm
helm install crossplane crossplane-stable/crossplane \
  --namespace crossplane-system --create-namespace

echo "Waiting for Crossplane Core to be ready..."
kubectl wait --for=condition=ready pod -l app=crossplane -n crossplane-system --timeout=120s

# 2. Install Provider and Function
echo "Installing Kubernetes Provider and Functions..."
kubectl apply -f ./p33k-challenge/crossplane/install/providers.yaml
kubectl apply -f ./p33k-challenge/crossplane/install/function-with-resources.yaml

echo "Waiting 60s for Provider and Function to initialize..."
sleep 60

# 3. Apply Permissions and Configuration
echo "Applying Provider Permissions and Configuration..."
kubectl apply -f ./p33k-challenge/crossplane/install/provider-permissions.yaml
kubectl apply -f ./p33k-challenge/crossplane/install/provider-config.yaml

# 4. Apply Platform Definitions (XRD and Composition)
echo "Applying XRD and Composition..."
kubectl apply -f ./p33k-challenge/crossplane/platform/xvotingapp-types.yaml
kubectl apply -f ./p33k-challenge/crossplane/platform/votingapp-composition.yaml

echo "Waiting 15s for API types to be established..."
sleep 15

# 5. Deploy the Application Claim
echo "Deploying the Voting App Claim..."
kubectl apply -f ./p33k-challenge/crossplane/app/myvotingapp.yaml

echo "Installation complete. Check status with 'kubectl get managed'"
