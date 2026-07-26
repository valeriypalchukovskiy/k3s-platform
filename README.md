```markdown
<div align="center">

# 🚀 K3s Platform

### Production-Ready Kubernetes GitOps Platform

[![CI/CD](https://github.com/valeriypalchukovskiy/k3s-platform/actions/workflows/ci-cd.yml/badge.svg)](https://github.com/valeriypalchukovskiy/k3s-platform/actions)
![K3s](https://img.shields.io/badge/K3s-v1.29-blue?logo=kubernetes)
![ArgoCD](https://img.shields.io/badge/ArgoCD-GitOps-red?logo=argo)
![Prometheus](https://img.shields.io/badge/Prometheus-Monitoring-orange?logo=prometheus)
![Grafana](https://img.shields.io/badge/Grafana-Dashboards-yellow?logo=grafana)

**От `git push` до production за 3 минуты, полностью автоматически.**

</div>

---

## 🎯 Обзор

Полноценная DevOps-платформа, реализующая современные практики:

- 🏗️ **Infrastructure as Code** — Ansible для настройки серверов
- 🔄 **GitOps** — ArgoCD для декларативного деплоя
- ⚙️ **CI/CD** — GitHub Actions для автоматизации
- 📊 **Observability** — Prometheus + Grafana для мониторинга
- 🔒 **Security** — UFW, Fail2Ban, SSH hardening

---

## 🏛️ Архитектура

```mermaid
graph TB
    subgraph "Developer Workflow"
        A[Developer] -->|git push| B[GitHub]
        B --> C[GitHub Actions]
        C -->|Lint + Build| D[GHCR Registry]
    end

    subgraph "GitOps Layer"
        E[ArgoCD] -->|Poll every 3 min| B
        E -->|Self-healing| F[(Git = Source of Truth)]
    end

    subgraph "K3s Cluster"
        direction LR
        subgraph "Master Node - 4GB"
            G[Control Plane]
            H[ArgoCD]
            I[Prometheus]
            J[Grafana]
        end
        subgraph "Worker Node - 1GB"
            K[K3s Agent]
            L[App Pods]
            M[Node Exporter]
        end
        G <-->|Flannel VXLAN| K
    end

    D -->|Pull Image| L
    E -->|Sync| H
    I -->|Scrape| M
    I -->|Scrape| L
    J -->|Query| I
```

---

## 🛠️ Технологический стек

| Категория | Технология | Назначение |
|-----------|------------|------------|
| **Orchestration** | K3s | Lightweight Kubernetes |
| **GitOps** | ArgoCD | Декларативный деплой |
| **CI/CD** | GitHub Actions | Автоматизация сборки |
| **Registry** | GHCR | Хранилище Docker-образов |
| **Packaging** | Helm 3 | Пакетный менеджер K8s |
| **Monitoring** | Prometheus + Grafana | Метрики и визуализация |
| **Networking** | Flannel VXLAN | Overlay сеть |
| **Security** | UFW, Fail2Ban | Hardening серверов |
| **IaC** | Ansible | Настройка серверов |

---

## 📸 Скриншоты

| Kubernetes Cluster | Running Pods | CI/CD Pipeline |
|:------------------:|:------------:|:--------------:|
| ![Nodes](screenshots/screenshot-01.png) | ![Pods](screenshots/screenshot-02.png) | ![GitHub Actions](screenshots/screenshot-03.png) |

| GitOps Dashboard | Prometheus Targets | Monitoring |
|:----------------:|:------------------:|:----------:|
| ![ArgoCD UI](screenshots/screenshot-04.png) | ![Prometheus](screenshots/screenshot-05.png) | ![Grafana](screenshots/screenshot-06.png) |

| Deployed App | App Details | Final Result |
|:------------:|:-----------:|:------------:|
| ![Application](screenshots/screenshot-07.png) | ![Details](screenshots/screenshot-08.png) | ![Result](screenshots/screenshot-09.png) |

> 💡 **Подсказка:** Если подписи не соответствуют содержимому скринов — просто переименуй файлы `screenshot-01.png` ... `screenshot-09.png` так, чтобы они соответствовали сетке.

---

## ✅ Что реализовано

### 🏗️ Инфраструктура

- Multi-Node K3s кластер на 2 VPS (Master + Worker)
- Overlay сеть через Flannel VXLAN
- Linux hardening: UFW firewall, Fail2Ban, SSH keys only
- Ansible playbooks для автоматической настройки серверов

### 🔄 CI/CD Pipeline

- GitHub Actions workflow с stages: `lint` → `build` → `push`
- Helm lint и YAML validation на каждый PR
- Docker multi-stage build с оптимизацией слоёв
- Автоматические теги (SHA коммита + `latest`)

### 🎯 GitOps

- ArgoCD с автоматической синхронизацией каждые 3 минуты
- Self-healing — ручные изменения откатываются автоматически
- Health checks и статусы синхронизации в UI

### 📊 Observability

- Prometheus со сбором метрик с обеих нод
- Grafana с 15+ импортированными дашбордами (1860, 315, 6417)
- Node Exporter + kube-state-metrics + cAdvisor

### 🛡️ Отказоустойчивость

- Автоматический rescheduling подов при падении ноды
- Zero-downtime rolling updates
- Git-based rollback через `git revert`

---

## 🎬 Как это работает

```
1. Разработчик вносит изменения → git push
        ↓
2. GitHub Actions автоматически:
   - Проверяет Helm charts (lint)
   - Собирает Docker-образ
   - Пушит в GHCR
        ↓
3. ArgoCD видит изменения в Git и применяет:
   - Обновляет Deployment в кластере
   - Rolling update без простоя
        ↓
4. Через 3 минуты приложение работает с новой версией ✨
```

---

## 📂 Структура проекта

```
k3s-platform/
├── .github/
│   └── workflows/
│       └── ci-cd.yml              # CI/CD pipeline
├── app/
│   ├── Dockerfile                 # Docker-образ приложения
│   ├── index.html                 # Кастомная landing page
│   └── nginx.conf                 # Конфигурация nginx
├── helm/
│   └── myapp/
│       ├── Chart.yaml             # Метаданные Helm chart
│       ├── values.yaml            # Параметры деплоя
│       └── templates/             # K8s манифесты (шаблоны)
├── manifests/
│   └── argocd/                    # ArgoCD Applications
├── screenshots/                   # Скриншоты для README
└── README.md
```

---

## 🚀 Быстрый старт

### Требования

- 2 VPS сервера (Ubuntu 22.04+, 4GB + 1GB RAM)
- `kubectl`, `helm` установлены локально
- GitHub аккаунт

### 1. Установи K3s

```bash
# На Master-ноде
curl -sfL https://get.k3s.io | sh -s - server --disable=traefik --flannel-backend=vxlan

# На Worker-ноде
curl -sfL https://get.k3s.io | K3S_URL=https://<master-ip>:6443 K3S_TOKEN=<token> sh -
```

### 2. Установи ArgoCD

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

### 3. Задеплой приложение

```bash
kubectl apply -f manifests/argocd/myapp.yaml
```

### 4. Установи мониторинг

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/kube-prometheus-stack -n monitoring --create-namespace
```


## 👤 Автор

**Valeriy Palchukovskiy**

[![GitHub](https://img.shields.io/badge/GitHub-valeriypalchukovskiy-black?logo=github)](https://github.com/valeriypalchukovskiy)
[![Email](https://img.shields.io/badge/Email-valeriy_palchukovskiy@mail.ru-blue?logo=gmail)](mailto:valeriy_palchukovskiy@mail.ru)

---

