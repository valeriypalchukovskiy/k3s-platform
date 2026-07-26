# 🚀 K3s Platform — Production-Ready Kubernetes GitOps Platform

[![CI/CD Pipeline](https://github.com/valeriypalchukovskiy/k3s-platform/actions/workflows/ci-cd.yml/badge.svg)](https://github.com/valeriypalchukovskiy/k3s-platform/actions)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-K3s-blue?logo=kubernetes)](https://k3s.io)
[![GitOps](https://img.shields.io/badge/GitOps-ArgoCD-red?logo=argo)](https://argoproj.github.io/cd/)
[![Monitoring](https://img.shields.io/badge/Monitoring-Prometheus+Grafana-orange?logo=prometheus)](https://prometheus.io)

**Pet-проект:** Полноценная DevOps-платформа с Multi-Node K3s, GitOps деплоем, CI/CD пайплайном и production-grade мониторингом. От `git push` до работающего приложения за 3 минуты, полностью автоматически.

---

## 🎯 Архитектура
┌─────────────────────────────────────────────────────────┐
│ DEVELOPER WORKFLOW │
│ Developer ──[git push]──→ GitHub Actions │
│ ├─ Lint (Helm, YAML) │
│ └─ Build (Docker → GHCR) │
└─────────────────────────────────────────────────────────┘
↓
┌─────────────────────────────────────────────────────────┐
│ GITOPS LAYER │
│ ArgoCD (каждые 3 мин) — Sync + Self-healing │
└─────────────────────────────────────────────────────────┘
↓
┌─────────────────────────────────────────────────────────┐
│ MULTI-NODE K3S CLUSTER │
│ Master (4GB) ◄────► Worker (1GB) │
│ • Control plane • K3s agent │
│ • ArgoCD • App pods │
│ • Prometheus • Node exporter │
│ • Grafana │
└─────────────────────────────────────────────────────────┘

---

## 🛠️ Технологический стек

| Категория | Технологии |
|-----------|------------|
| **Orchestration** | K3s (lightweight Kubernetes) |
| **GitOps** | ArgoCD |
| **CI/CD** | GitHub Actions |
| **Registry** | GitHub Container Registry (GHCR) |
| **Packaging** | Helm 3 |
| **Monitoring** | Prometheus + Grafana |
| **Networking** | Flannel VXLAN |
| **Security** | UFW, Fail2Ban, SSH keys only |

---

## 📸 Скриншоты

<details>
<summary><b>🖼️ Показать все скриншоты (7)</b></summary>

### GitHub Actions — автоматическая сборка и линтинг
![GitHub Actions](screenshots/screenshot-01.png)

### ArgoCD UI — GitOps деплой с self-healing
![ArgoCD](screenshots/screenshot-02.png)

### Grafana — мониторинг кластера
![Grafana Dashboard](screenshots/screenshot-03.png)

### Prometheus Targets — метрики с обеих нод
![Prometheus Targets](screenshots/screenshot-04.png)

### Kubernetes Cluster — 2 ноды Ready
![Kubernetes Nodes](screenshots/screenshot-05.png)

### Работающие поды приложения
![Kubernetes Pods](screenshots/screenshot-06.png)

### Задеплоенное приложение в браузере
![Application](screenshots/screenshot-07.png)

</details>

---

## ✅ Что реализовано

### Инфраструктура
- ✅ **Multi-Node K3s** (Master + Worker на VPS)
- ✅ **Overlay сеть** через Flannel VXLAN
- ✅ **Linux hardening**: UFW, Fail2Ban, SSH keys only
- ✅ **Автоматическая настройка** серверов через Ansible

### CI/CD Pipeline
- ✅ **GitHub Actions** workflow с stages: lint → build → push
- ✅ **Helm lint** и **YAML validation** на каждый PR
- ✅ **Docker build** с оптимизированными слоями
- ✅ **Push to GHCR** с автоматическими тегами (SHA + latest)

### GitOps
- ✅ **ArgoCD** для декларативного деплоя
- ✅ **Automated sync** + **self-healing**
- ✅ **Health checks** и **sync status** мониторинг

### Monitoring & Observability
- ✅ **Prometheus** со сбором метрик с обеих нод
- ✅ **Grafana** с дашбордами (1860, 315, 6417)
- ✅ **Node Exporter** + **kube-state-metrics** + **cAdvisor**

### Отказоустойчивость
- ✅ **Automatic pod rescheduling** при падении ноды
- ✅ **Rolling updates** без простоя
- ✅ **Git-based rollback** через `git revert`

---

## 🎯 Ключевые фичи

### 1. От коммита до production за 3 минуты

```bash
git commit -m "feat: new feature"
git push origin main
# → GitHub Actions → GHCR → ArgoCD → Kubernetes → App running!
```

2. Self-healing кластера
ArgoCD автоматически откатывает ручные изменения через kubectl patch — Git остаётся единственным источником правды.
3. Production-grade мониторинг
Метрики с обеих нод (Master + Worker)
15+ дашбордов Grafana
ServiceMonitor CRD для автоматического discovery


📂 Структура проекта

k3s-platform/
├── .github/workflows/ci-cd.yml     # GitHub Actions pipeline
├── app/
│   ├── Dockerfile                  # Docker образ приложения
│   ├── index.html                  # Кастомная landing page
│   └── nginx.conf                  # Конфиг nginx
├── helm/myapp/
│   ├── Chart.yaml                  # Метаданные chart
│   ├── values.yaml                 # Параметры
│   └── templates/                  # K8s манифесты
├── manifests/argocd/               # ArgoCD Applications
├── screenshots/                    # Скриншоты проекта
└── README.md

🚀 Быстрый старт

# 1. Клонируй
git clone https://github.com/valeriypalchukovskiy/k3s-platform.git
cd k3s-platform

# 2. Настрой K3s на Master
curl -sfL https://get.k3s.io | sh -s - server --flannel-backend=vxlan

# 3. Установи ArgoCD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# 4. Deploy приложение
kubectl apply -f manifests/argocd/myapp.yaml

# 5. Monitoring stack
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/kube-prometheus-stack \
  -n monitoring --create-namespace

🎓 Чему я научился
Проектировать production-ready Kubernetes архитектуру
Строить GitOps workflow с ArgoCD
Настраивать CI/CD pipeline через GitHub Actions
Писать Helm charts с шаблонами
Внедрять observability через Prometheus + Grafana
Обеспечивать безопасность через Linux hardening
Troubleshoot проблемы на всех уровнях
🗺️ Roadmap
Vaultwarden — self-hosted password manager
Telegram alerts через Alertmanager
Loki для централизованных логов
cert-manager + Let's Encrypt для HTTPS
GitLab CI (гибридный CI/CD)
👤 Автор
Valeriy Palchukovskiy
GitHub: @valeriypalchukovskiy
Email: valeriy_palchukovskiy@mail.ru
<p align="center">
<b>⭐ Если проект был полезен — поставь звезду!</b>
</p>
