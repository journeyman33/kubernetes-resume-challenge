# Kubernetes Resume Challenge

This repo contains the code for the **Kubernetes Resume Challenge** outlined in my blog:  
👉 [https://journeyman33.github.io/k8s-resume-blog/](https://journeyman33.github.io/k8s-resume-blog/)

---

### Cloud Resume Challenge
A hands-on project designed to deepen your understanding of **cloud services** through the practical application of building and deploying a resume.  
This challenge is an excellent way to apply what you've learned in a **real-world DevOps scenario**, enhancing both your **Kubernetes** and **cloud engineering** skills.  
For more details, visit [Cloud Resume Challenge](https://cloudresumechallenge.dev).

---

### KodeKloud
An interactive learning platform that offers hands-on labs, courses, and real-world simulations focused on **DevOps**, **Cloud**, and **Kubernetes** practices.  
KodeKloud has been a major part of my DevOps learning journey — from **CKA/CKS certifications** to the **DevOps Architect path**.  
Explore more at [KodeKloud](https://kodekloud.com).

---

## 🚀 Overview
This project extends the original **Cloud Resume Challenge** into a **Kubernetes-native implementation** — built and deployed entirely on **Civo Cloud**, a lightweight and developer-friendly Kubernetes provider.

### Why Civo?
When starting the challenge, I intentionally chose **Civo** as my cloud platform because of:
- Its **fast cluster provisioning** and **K3s-based lightweight design**
- Developer-friendly **UI and CLI tooling**
- **Cost-effective** cloud resources suitable for experimentation and learning
- Seamless **integration with GitHub Actions** for CI/CD

---

## 🧠 Architecture Summary
The project demonstrates a full **DevOps lifecycle**, combining GitOps principles, IaC, and continuous deployment.

Key components:
- **Frontend:** Static resume web app hosted via Apache HTTP + PHP Container
- **Kubernetes Cluster:** Managed on **Civo Cloud**
- **CI/CD Pipeline:** GitHub Actions for automated build, test, and deploy
- **Infrastructure as Code:** Terraform for cluster provisioning
- **Monitoring:** Basic Prometheus/Grafana stack setup (optional)
- **Ingress Controller:** NGINX for route handling and HTTPS exposure

%%{init: {'theme':'forest', 'themeVariables': { 'primaryColor': '#91c9f7', 'edgeLabelBackground':'#ffffff'}}}%%
graph TD
    subgraph Developer_Workstation["💻 Developer Workstation"]
        laptop[Local Dev Environment]
        openfaas[OpenFaaS / Raspberry Pi]
        laptop --> openfaas
    end

    laptop -->|Push Code| github[(GitHub Repo)]
    github -->|Triggers Workflow| actions[GitHub Actions CI/CD]
    actions -->|Build & Push Images| dockerhub[(Docker Hub Registry)]

    subgraph Civo_Cloud["☁️ Civo Managed K3s Cluster"]
        subgraph Node_Subnet["Node Subnet"]
            ingress[Ingress Controller / LoadBalancer]
            web[Web Frontend Service]
            ecom[E-Commerce API Service]
            mysql[(MySQL Database)]
            deploy1[Deployment Controller - Web]
            deploy2[Deployment Controller - Ecom]
            
            ingress --> web
            ingress --> ecom
            web --> mysql
            ecom --> mysql
            deploy1 --> web
            deploy2 --> ecom
        end
    end

    dockerhub -->|Pull Container Images| Civo_Cloud
    github -->|VPN + Secure Access| Firewall[Firewall + DNS]
    Firewall -->|Routes External Traffic| Civo_Cloud



---

## 🧰 Tools and Technologies
| Category | Tools / Services |
|-----------|------------------|
| Cloud | **Civo (K3s)** |
| IaC | **Terraform** |
| CI/CD | **GitHub Actions** |
| Containerization | **Docker** |
| Orchestration | **Kubernetes (Helm, YAML)** |
| Monitoring | **Prometheus, Grafana** |
| Learning Platform | **KodeKloud** |

---

## 🗒️ Notes
- This repository documents my personal implementation, configuration, and deployment workflow for the Kubernetes Resume Challenge.
- Each section of the repo aligns with key DevOps principles — automation, repeatability, and observability.
- For a full walkthrough, including diagrams and deployment details, see my accompanying blog series.

---

📫 **Contact:** [voslooc@gmail.com](mailto:voslooc@gmail.com)

---

> _“Learning by doing — that’s the essence of DevOps. Every cluster tells a story.”_
