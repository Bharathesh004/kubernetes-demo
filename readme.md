# Hii There this is a kubernetes Crash Course 

# 🚀 Kubernetes-L1 API Deployment

This project demonstrates how to **containerize**, **push**, and **deploy** a Node.js application to a **Kubernetes cluster** using **Minikube** and **Docker**.  
Follow the guide below to build, deploy, and manage your first Kubernetes-based microservice!

---

## 🌐 Overview

This repository contains:
- A **Dockerfile** to build the API image  
- **Kubernetes manifests** (`deployment.yaml`, `service.yaml`) for deployment and service configuration  
- A **deployment script** to automate the build and deployment process  

---

## ⚙️ Prerequisites

Before you begin, ensure you have the following installed:

- [Docker](https://docs.docker.com/get-docker/)
- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Git](https://git-scm.com/)

---

## 🧩 Step 1: Set Up Minikube (Kubernetes Cluster)

### 1️⃣ Start Minikube
```bash
minikube start
```
> This creates a local single-node Kubernetes cluster on your machine.

### 2️⃣ Check Cluster Status
```bash
minikube status
```

### 3️⃣ Configure Docker to Use Minikube's Environment
```bash
eval $(minikube docker-env)
```
> This ensures that your Docker images are built directly into the Minikube Docker environment.

---

## 🐳 Step 2: Build and Push Docker Image

### 1️⃣ Build Docker Image
```bash
docker build -t demo/kubernetes-l1-api:latest .
```

### 2️⃣ Push Image to Docker Hub
Make sure you're logged into Docker Hub first:
```bash
docker login
```

Then push your image:
```bash
docker push demo/kubernetes-l1-api:latest
```

> Replace `demo` with your Docker Hub username if needed.

---

## ☸️ Step 3: Configure Kubernetes Files

### 📁 Deployment File: `k8s/deployment.yaml`
This defines how your application runs inside the cluster.

Key configurations:
- **replicas**: Number of pod instances
- **image**: Docker image name
- **ports**: Container port exposed

Example snippet:
```yaml
containers:
  - name: kubernetes-l1-api
    image: demo/kubernetes-l1-api:latest
    ports:
      - containerPort: 3000
```

### 📁 Service File: `k8s/service.yaml`
This file exposes your application within the cluster.

Example snippet:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: kubernetes-l1-api-service
spec:
  type: NodePort
  selector:
    app: kubernetes-l1-api
  ports:
    - port: 3000
      targetPort: 3000
      nodePort: 30080
```

---

## 🧠 Step 4: Deploy Application to Kubernetes

You can manually apply manifests or use the automation script.

### Option 1 — Manual Deployment
```bash
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

### Option 2 — Using the Script

Run the deployment script:
```bash
bash deploy.sh
```

This script performs the following:
```bash
set -e

NAME="kubernetes-l1-api"
USERNAME="demo"
IMAGE="$USERNAME/$NAME:latest"

echo "Building docker image.."
docker build -t $IMAGE .

echo "Pushing image to dockerhub.."
docker push $IMAGE

echo "Applying kubernetes manifests.."
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

echo "Getting PODS..."
kubectl get pods 

echo "Getting services..."
kubectl get services

echo "Fetching the main service.."
kubectl get service $NAME-service
```

---

## 🧩 Step 5: Verify Deployment

### Check Pods
```bash
kubectl get pods
```

### Check Services
```bash
kubectl get services
```

### Get NodePort URL
To access your app in the browser:
```bash
minikube service kubernetes-l1-api-service --url
```
Then open the displayed URL in your browser.

---

## 🧹 Step 6: Cleanup Resources

To delete all resources created:
```bash
kubectl delete -f k8s/deployment.yaml
kubectl delete -f k8s/service.yaml
minikube stop
```

---

## 🧾 Summary

✅ Built Docker image  
✅ Pushed image to Docker Hub  
✅ Created Kubernetes deployment and service  
✅ Deployed and accessed the app on Minikube  

---

## 💡 Tip

If you ever face issues with outdated images in Minikube, run:
```bash
eval $(minikube docker-env)
docker rmi demo/kubernetes-l1-api:latest
```
Then rebuild your image again.

---

## ✨ Author

**Kubernetes-L1 Project Demo**  
Built with ❤️ to simplify learning Kubernetes basics.
