# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [0.1.0] - 2026-07-24

### Added
- Initial project structure
- Terraform modules for VPS infrastructure
- Ansible playbooks for server hardening and K3s installation
- Helm chart for web application deployment
- GitHub Actions CI/CD pipeline
- ArgoCD application manifests
- Monitoring stack configuration (Prometheus, Grafana, Loki)
- Comprehensive README with architecture diagrams

### Infrastructure
- Multi-Node K3s cluster setup (Master + Worker)
- Overlay network with Flannel (VXLAN)
- Nginx Ingress Controller with automatic SSL
- Resource optimization for low-memory VPS

### Security
- SSH hardening and key-based authentication
- UFW firewall configuration
- Fail2Ban for brute-force protection
- Automatic swap disabling for Kubernetes

### Documentation
- Architecture diagrams
- Deployment guides
- Troubleshooting runbooks
