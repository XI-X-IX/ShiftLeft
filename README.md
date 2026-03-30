# DevOps Pipeline - Secure Cloud Application

## Overview

This project demonstrates a complete Dev(Sec)Ops pipeline from development to deployment.  
It includes security best practices integrated into the CI/CD process, infrastructure as code, and containerized deployment.

![Build Status](https://github.com/XI-X-IX/DevOps/actions/workflows/pipeline.yml/badge.svg)
![Python](https://img.shields.io/badge/python-3.11-blue)
![Trivy Scan](https://img.shields.io/badge/Trivy-Secure-brightgreen)
![Bandit Scan](https://img.shields.io/badge/Bandit-Clean-brightgreen)
![License](https://img.shields.io/github/license/XI-X-IX/DevOps)

**Key Features:**
- Dockerized Python Flask application
- CI/CD pipeline with GitHub Actions
- Security scans: SAST (Bandit), dependency scan (Safety), secrets scan (TruffleHog)
- Container vulnerability scan (Trivy)
- Infrastructure as Code with Terraform
- Kubernetes deployment configuration
- Artifact upload for security reports

---

## Project Structure
```
pipeline-project/
│
├── app/ # Application source code
│ ├── main.py
│ ├── requirements.txt
│ └── Dockerfile
│
├── k8s/ # Kubernetes deployment
│ ├── deployment.yaml
│ └── service.yaml
│
├── terraform/ # Infrastructure as Code
│ ├── main.tf
│ └── variables.tf
│
├── security/ # Security configuration
│ ├── bandit.yaml
│ ├── safety-policy.json
│ ├── secrets.toml
│ └── trivy.yaml
│
├── .github/workflows/ # CI/CD pipeline
│ └── pipeline.yml
│
└── README.md
```

---

## CI/CD Pipeline

The pipeline automates the following steps:

1. Checkout source code
2. Setup Python environment
3. Install dependencies and security tools (Bandit, Safety, Trivy)
4. Run secrets scanning with TruffleHog
5. Run SAST using Bandit
6. Run dependency scanning with Safety
7. Build Docker image
8. Scan Docker image for vulnerabilities with Trivy
9. Upload security reports as artifacts
10. Exit with failure if any critical/high vulnerability is detected

This ensures that all code changes are automatically checked for security issues before deployment.

---

## Security Implementation

### Static Application Security Testing (SAST)
- Configured in `security/bandit.yaml`
- Scans Python code for common vulnerabilities

### Dependency Scanning
- Configured in `security/safety-policy.json`
- Checks installed libraries for known vulnerabilities

### Secrets Management
- TruffleHog scans Git history and committed files
- `security/secrets.toml` defines allowlist rules

### Container Scanning
- Trivy scans Docker images for CVEs
- Configured to fail build on HIGH and CRITICAL vulnerabilities

### Kubernetes Security (Optional)
- SecurityContext ensures pods run as non-root
- Deployment YAML follows best practices for container security

---

## Infrastructure as Code

- Terraform used to provision AWS resources (EC2, S3, IAM)
- Ensures infrastructure is versioned, reproducible, and auditable
- Can be extended to deploy Kubernetes clusters

---

## How to Run

1. Clone the repository
2. Install dependencies:
   ```bash
   pip install -r app/requirements.txt
   pip install bandit safety