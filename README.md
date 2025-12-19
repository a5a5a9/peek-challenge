# peek-challenge



This project deploys a simple voting application (UI + API + PostgreSQL) to a **local Kubernetes cluster** using **Crossplane compositions** as the primary **Infrastructure as Code (IaC)** tool.

The goal is to provide a **fast, reproducible setup** that developers can run locally with minimal manual configuration.

---

## Architecture (High Level)

- **Votes UI** – Node.js web app (HTTP + WebSocket)
- **Votes API** – Python / Flask backend
- **PostgreSQL** – In-cluster database
- **Kubernetes** – Local cluster via `kind`
- **Crossplane** – IaC control plane using compositions

All application components are deployed via a **single Crossplane composite resource**.

---

## Prerequisites

Make sure you have the following installed:

- Docker
- kind
- kubectl
- Helm
- Bash (macOS / Linux / WSL)



---

## Repository Structure

```text
.
├── kind/                  # kind cluster configuration
├── crossplane/            # Crossplane platform definitions
│   ├── install/           # Crossplane providers
│   ├── platform/          # XRD + Composition
│   └── app/               # Application claim
├── apps/                  # Application source code
└── README.md


# Setup

This project deploys a full **Voting Application Platform** on a local Kubernetes cluster using **Kind + Crossplane**.

The objective is:
- Minimal manual configuration
- Infrastructure as Code via Crossplane
- A single declarative object to deploy the entire application

---

## Prerequisites

Make sure you have the following installed:

- Docker
- kubectl
- kind
- Git
- Helm


---

## Clone this Repo

~$ git clone https://github.com/a5a5a9/peek-challenge

## Clone the devops-challenge project inside ./peek-challenge directory

./peek-challenge$ git clone https://github.com/gadabout/devops-challenge

## Create the Kubernetes Cluster (Kind)

This project uses **kind** to provide a fast and reproducible local Kubernetes environment.

### Create the cluster

./setup-kind-cluster.sh


### Build and Load images to kind 

./build_and_load.sh

## Install Crossplane stack with a script or manually 


## With a Script

peek-challenge$./deploy-crossplane-stack.sh

This script "deploy-crossplane-stack.sh"  will deploy everything. After is completed continue with "Test UI App" Phase.

## Manually entering kubectl commands:

helm install crossplane crossplane-stable/crossplane \
  --namespace crossplane-system --create-namespace

## Wait Until Crossplane Is Ready

After installing Crossplane, ensure that all Crossplane system components are running before continuing.

kubectl get pods -n crossplane-system


## Configure Crossplane Providers and function
kubectl apply -f ./p33k-challenge/crossplane/install/providers.yaml
kubectl apply -f ./p33k-challenge/crossplane/install/function-with-resources.yaml

Verify that the providers are installed and healthy:
kubectl get providers
kubectl get functions


## Now Apply the following commands:
kubectl apply -f ./p33k-challenge/crossplane/install/provider-config.yaml
kubectl apply -f ./p33k-challenge/crossplane/platform/xvotingapp-types.yaml
kubectl apply -f ./p33k-challenge/crossplane/platform/votingapp-composition.yaml

## Verify the health status of the components
kubectl get providerconfig
kubectl get xrd
kubectl get composition


## Finally deploy the App

kubectl apply -f ./p33k-challenge/crossplane/app/myvotingapp.yaml

## Verify STATUS is running

kubectl get xvotingapp
kubectl get managed
kubectl get pods,svc,endpoints


## Test UI App

kubectl port-forward svc/vote 30000:80

http://127.0.0.1:30000/




## Delete your kind cluster

kind delete cluster --name voting-platform



