<div align="center">

![SecureCI](./secureci-banner.png)

# ⚙️ SecureCI Pipeline — Secure Cloud Application

### *End-to-end DevSecOps pipeline: from code to container, with security baked in at every stage.*

![DevSecOps](https://img.shields.io/badge/DevSecOps-E83E8C?style=flat)
![Python](https://img.shields.io/badge/Python-3.11-3776AB?style=flat&logo=python&logoColor=white)
![Flask](https://img.shields.io/badge/Flask-000000?style=flat&logo=flask&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=flat&logo=terraform&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=flat&logo=kubernetes&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-2088FF?style=flat&logo=githubactions&logoColor=white)

<br>

![Trivy](https://img.shields.io/badge/Trivy-Secure-brightgreen?style=flat)
![Bandit](https://img.shields.io/badge/Bandit-Clean-brightgreen?style=flat)
![Safety](https://img.shields.io/badge/Safety-Passing-brightgreen?style=flat)
![TruffleHog](https://img.shields.io/badge/TruffleHog-No%20secrets-brightgreen?style=flat)

</div>

---

## 🎯 Overview

A complete **Dev(Sec)Ops pipeline** demonstrating how to ship a containerized Python application safely — from source code to Kubernetes deployment — with **security gates at every step**.

The pipeline fails the build if *any* HIGH/CRITICAL vulnerability is introduced: in the code (SAST), in dependencies (SCA), in committed secrets, or in the final Docker image.

---

## 🎬 Demo


**Example pipeline stages** (GitHub Actions):

```
✅ Checkout                         1s
✅ Setup Python 3.11                3s
✅ Install security tools           12s
✅ TruffleHog — secrets scan        8s
✅ Bandit — SAST on app/            4s
✅ Safety — dependency scan         6s
✅ Docker build                     45s
✅ Trivy — image scan               22s
✅ Upload security artifacts        2s

Status: success — 0 HIGH, 0 CRITICAL
```

---

## ✨ Features

- 🐳 **Dockerized Flask app** — minimal base image, non-root user
- 🔁 **GitHub Actions CI/CD** — fully automated from `git push` to deployment-ready artifact
- 🔒 **SAST** — Bandit scans Python code for common vulnerabilities (SQLi, hardcoded creds, weak crypto)
- 📦 **SCA** — Safety checks dependencies against the CVE database
- 🔐 **Secrets scanning** — TruffleHog scans commits and Git history
- 🖼️ **Container scanning** — Trivy flags CVEs in the image layers
- 🏗️ **Infrastructure as Code** — Terraform provisions cloud resources
- ☸️ **Kubernetes manifests** — deployment + service with security best practices
- 📊 **Artifact uploads** — every security report is saved as a pipeline artifact

---

## 🧱 Stack

| Layer | Tool |
|-------|------|
| Application | Python 3.11 · Flask |
| Container | Docker |
| CI/CD | GitHub Actions |
| SAST | Bandit |
| SCA | Safety |
| Secrets | TruffleHog |
| Image scan | Trivy |
| IaC | Terraform (AWS) |
| Orchestration | Kubernetes |

---

## 📂 Project Structure

```
FirstWorkflow/
├── app/                     # Python Flask application
│   ├── main.py
│   ├── requirements.txt
│   └── Dockerfile
├── k8s/                     # Kubernetes manifests
│   ├── deployment.yaml
│   └── service.yaml
├── terraform/               # Infrastructure as Code
│   ├── main.tf
│   └── variables.tf
├── security/                # Scanner configurations
│   ├── bandit.yaml
│   ├── safety-policy.json
│   ├── secrets.toml
│   └── trivy.yaml
└── .github/workflows/
    └── pipeline.yml         # CI/CD pipeline definition
```

---

## 🚀 Quick Start

### Run the app locally

```bash
pip install -r app/requirements.txt
python app/main.py
# → http://127.0.0.1:5000
```

### Run security scans locally

```bash
pip install bandit safety
bandit -r app/ -c security/bandit.yaml
safety check -r app/requirements.txt --policy-file security/safety-policy.json
```

### Build & scan the Docker image

```bash
docker build -t secure-flask:latest app/
trivy image --config security/trivy.yaml secure-flask:latest
```

### Trigger the pipeline

```bash
git push origin main
# → GitHub Actions runs the full pipeline automatically
```

---

## 🧩 CI/CD Pipeline

The pipeline (`.github/workflows/pipeline.yml`) executes these stages in order:

1. **Checkout** source code
2. **Setup** Python environment
3. **Install** dependencies and security tools
4. **TruffleHog** — scan commits and Git history for secrets
5. **Bandit** — static analysis on the Python source
6. **Safety** — dependency vulnerability scan
7. **Build** the Docker image
8. **Trivy** — scan the image for CVEs
9. **Upload** all security reports as pipeline artifacts
10. **Fail** the build if any HIGH / CRITICAL vulnerability is detected

Every code change is automatically gated by these checks before anything reaches production.

---

## 🔒 Security Implementation

**Static Application Security Testing (SAST)** — `security/bandit.yaml` tunes Bandit for the Flask app: SQLi, hardcoded credentials, weak crypto, insecure deserialization.

**Dependency Scanning (SCA)** — `security/safety-policy.json` defines exceptions for accepted/low-risk CVEs; everything else fails the build.

**Secrets Management** — TruffleHog scans the full Git history; `security/secrets.toml` holds allowlist rules to avoid false positives on test fixtures.

**Container Scanning** — Trivy is configured via `security/trivy.yaml` to fail on `HIGH` and `CRITICAL`; lower severities are logged but non-blocking.

**Kubernetes Hardening** — pods run as non-root, read-only root filesystem, resource limits set, no privilege escalation.

---

## 🏗️ Infrastructure as Code

Terraform provisions the AWS resources (EC2, S3, IAM) with versioned, reproducible, auditable state — a clean foundation for deploying the Kubernetes cluster.

---

## 🗺️ Roadmap

- [ ] **DAST** stage with OWASP ZAP against a staging deployment
- [ ] **SBOM** generation with Syft + signing with Cosign (supply-chain hardening)
- [ ] **Policy-as-Code** gates with OPA / Conftest on Kubernetes manifests
- [ ] **IaC scanning** with Checkov / tfsec on Terraform
- [ ] **Dependabot** for automated dependency PRs
- [ ] Progressive delivery (canary / blue-green) via Argo Rollouts
- [ ] Observability: Prometheus + Grafana + Loki for metrics, logs, and alerts

---

## 🎓 What I learned

- **Shift-left security** — catching vulnerabilities in CI is 100× cheaper than catching them in production
- **Layered defense** — SAST, SCA, secrets, and image scanning each catch different classes of issues
- **Pipeline design** — fast-failing stages first (lint/secrets) before expensive stages (container scans)
- **Supply chain** — understanding that the image I ship is a sum of *every layer*, not just my code
- **IaC discipline** — Terraform state management, variable segregation, and module structure
- **Kubernetes security context** — the difference between a pod that *runs* and one that runs *safely*

---

## 📜 Context

Personal learning project — built to internalize the full DevSecOps lifecycle end-to-end.
Inspired by industry references: OWASP DevSecOps Maturity Model, Google SLSA, NIST SP 800-190.
