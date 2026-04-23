# Green-GPU Orchestrator: Sustainable Fractional GPU Infrastructure

## 🎯 Purpose
This project is a production-grade implementation of a **Sustainable GPU Cloud** architecture, specifically designed to solve the "GPU Availability & Efficiency Gap" faced by AI hyperscalers like **Nscale**.

It enables **Fractional GPU-as-a-Service** on AWS EKS, allowing multiple AI models to share high-density GPU nodes (H100/G5) with strict resource isolation and event-driven autoscaling.

## 🚀 Key Features
- **GPU Fractionalization:** Uses NVIDIA Device Plugin with **Time-Slicing** to divide a single GPU into 10 virtual replicas, increasing hardware utilization by up to 1000%.
- **Event-Driven Scaling (KEDA):** Scales inference workloads based on **Inference Queue Depth** rather than generic CPU/RAM metrics, ensuring sub-second responsiveness to AI traffic bursts.
- **Green-Aware Orchestration:** A Python-based admission controller logic (simulated) that prioritizes workloads based on data center renewable energy availability.
- **Automated GitOps Pipeline:** Full CI/CD via GitHub Actions for Infrastructure-as-Code (Terraform) and Kubernetes manifests.

## 🏗 Architecture
1. **Cloud Provider:** AWS (EKS v1.29)
2. **Infrastructure:** Terraform (Modular VPC, Managed GPU Node Groups)
3. **Orchestration:** Kubernetes + NVIDIA Device Plugin (Time-Slicing mode)
4. **Scaling:** KEDA (Kubernetes Event-Driven Autoscaling)
5. **Monitoring:** Prometheus + NVIDIA DCGM Exporter

## 📁 Project Structure
```text
.
├── .github/workflows/    # CI/CD: Automated Terraform Plan/Apply
├── terraform/            # IaC: EKS Cluster & GPU Node Groups (G4dn/G5)
├── kubernetes/           # K8s: NVIDIA Plugin & KEDA ScaledObjects
├── src/                  # Logic: GPU Stress Test & Inference Simulation
└── README.md             # Project Documentation
```

## 🛠 Setup & Deployment

### Prerequisites
- AWS CLI & Terraform installed
- GitHub repository secrets configured (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`)

### 1. Provision Infrastructure
The infrastructure is managed via GitHub Actions. On every push to `main`, Terraform will:
1. Create a VPC with 2 Private/2 Public subnets.
2. Deploy an EKS cluster with a GPU-optimized Managed Node Group.
3. Apply taints (`nvidia.com/gpu:NoSchedule`) to ensure only AI workloads run on expensive GPU nodes.

### 2. Enable GPU Fractionalization
Apply the NVIDIA configuration to enable 10 replicas per physical GPU:
```bash
kubectl apply -f kubernetes/nvidia-device-plugin.yaml
```

### 3. Verify Fractional Sharing
Deploy the stress-test suite to confirm multiple pods are sharing one GPU:
```bash
# Simulates 4 independent AI models on a single GPU
kubectl apply -f kubernetes/test-inference-deployment.yaml
kubectl get pods -l app=gpu-inference
```

## 📊 Monitoring & Sustainability
The stack includes a mock "Green Score" monitoring layer. In a production Nscale environment, this would integrate with the **Glomfjord Hydropower Grid API** to shift non-critical training jobs to periods of 100% renewable surplus.

---
**Author:** Kindson Nathaniel Egbule  
**Role:** Junior Cloud Engineer  
**Portfolio:** [GitHub Link]
