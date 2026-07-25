# 🚀 Production-Ready K3s Platform

[![CI/CD Pipeline](https://github.com/valeriypalchukovskiy/k3s-platform/actions/workflows/ci-cd.yml/badge.svg)](https://github.com/valeriypalchukovskiy/k3s-platform/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Полноценная Kubernetes-платформа на базе **K3s** с Multi-Node архитектурой, GitOps-подходом, CI/CD пайплайнами и полным стеком observability.

> 💡 **Статус проекта:** Активная разработка (Июнь 2026 – настоящее время)

---

## 🎯 О проекте

Платформа развернута на **двух VPS** от разных провайдеров (UltraVDS + JustHost) для демонстрации работы распределённого кластера в production-окружении.

### Ключевые возможности

- ✅ **Multi-Node K3s кластер** (Master + Worker) с overlay-сетью Flannel (VXLAN)
- ✅ **Infrastructure as Code** через Terraform и Ansible
- ✅ **GitOps подход** с ArgoCD для автоматической синхронизации
- ✅ **CI/CD на GitHub Actions** (< 2 минут от коммита до production)
- ✅ **Автоматический SSL** через cert-manager + Let's Encrypt
- ✅ **Полный observability stack:** Prometheus, Grafana, Loki, Alertmanager
- ✅ **Production-grade безопасность:** SSH hardening, UFW, Fail2Ban, RBAC

### Результаты

| Метрика | До автоматизации | После |
|---------|------------------|-------|
| **Время деплоя** | 15 минут (ручной) | **< 2 минут** |
| **Использование RAM** | 12+ GB (full K8s) | **5 GB** (K3s) |
| **Автоматизация** | 20% | **100%** |
| **Восстановление при сбое** | ~15 минут | **< 30 секунд** |

---

## 🏗 Архитектура

**Master Node (UltraVDS, 2 vCPU / 4 GB RAM):**
- K3s API Server — единая точка входа
- ArgoCD — GitOps оператор
- Prometheus + Grafana + Loki — observability stack
- Nginx Ingress Controller + cert-manager — HTTPS трафик
- Gitea — self-hosted Git (backup)

**Worker Node (JustHost, 1 vCPU / 1 GB RAM):**
- kubelet + kube-proxy + containerd
- Flannel CNI (VXLAN overlay)
- Application Pods (реплики распределены между нодами)

**Связь между нодами:** VXLAN туннель через UDP 8472

---

## 🛠 Технологический стек

| Слой | Технологии |
|------|-----------|
| **Оркестрация** | K3s v1.36, kubectl, Helm 3 |
| **Контейнеризация** | Docker, containerd |
| **IaC** | Terraform 1.9, Ansible 2.17 |
| **CI/CD** | GitHub Actions, ArgoCD |
| **Сеть** | Flannel (VXLAN), Nginx Ingress |
| **TLS** | cert-manager, Let's Encrypt |
| **Мониторинг** | Prometheus, Grafana, Alertmanager |
| **Логи** | Loki, Promtail |
| **Git** | GitHub (основной), Gitea (self-hosted) |
| **ОС** | Ubuntu 24.04 LTS |

---

## 🚀 Быстрый старт

### 1. Подготовка инфраструктуры (Terraform)

    cd terraform
    terraform init
    terraform plan
    terraform apply

### 2. Настройка серверов (Ansible)

    cd ansible
    ansible-playbook -i inventories/production.ini playbooks/setup-k3s.yml

### 3. Установка observability stack

    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    helm install prometheus prometheus-community/kube-prometheus-stack \
      --namespace monitoring --create-namespace

### 4. Настройка ArgoCD

    kubectl create namespace argocd
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    kubectl apply -f argocd/applications/

---

## 📂 Структура репозитория

    k3s-platform/
    ├── terraform/              # Infrastructure as Code
    ├── ansible/                # Configuration Management
    ├── helm/                   # Helm Charts
    ├── k8s/                    # Kubernetes manifests
    ├── argocd/                 # GitOps конфигурация
    ├── monitoring/             # Observability stack
    ├── .github/workflows/      # CI/CD pipelines
    ├── docs/                   # Документация
    ├── scripts/                # Вспомогательные скрипты
    ├── README.md
    ├── CHANGELOG.md
    └── .gitignore

---

## 🔄 CI/CD Pipeline

**push to main → lint → build Docker image → push to GHCR → update Helm values → ArgoCD sync → deploy to K3s**

**Общее время:** ~2 минуты от коммита до production

---

## 🛡 Безопасность

- ✅ SSH hardening (только ключевая аутентификация)
- ✅ UFW firewall (открыты только необходимые порты)
- ✅ Fail2Ban (защита от брутфорса)
- ✅ Swap disabled (требование Kubernetes)
- ✅ RBAC (минимальные привилегии)
- ✅ Network Policies (изоляция traffic)
- ✅ Automatic TLS (HTTPS для всех ingress)

---

## 🚧 Roadmap

- [ ] HashiCorp Vault для управления секретами
- [ ] Velero для backup кластера
- [ ] Trivy для сканирования Docker-образов
- [ ] Argo Rollouts для canary-деплоя
- [ ] KEDA для event-driven autoscaling

---

## 👤 Автор

**Валерий Пальчуковский**
- 📧 valeriy_palchukovskiy@mail.ru
- 🐙 [GitHub](https://github.com/valeriypalchukovskiy)

---

## 📄 Лицензия

MIT License. Свободно используйте и модифицируйте.
