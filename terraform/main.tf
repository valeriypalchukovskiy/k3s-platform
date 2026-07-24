terraform {
  required_version = ">= 1.9.0"
  
  required_providers {
    # В реальности здесь был бы провайдер твоего VPS
    # Например: yandex, digitalocean, hetzner
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

# Описание инфраструктуры
locals {
  project_name = "k3s-platform"
  environment  = "production"
  
  servers = {
    master = {
      name     = "${local.project_name}-master"
      vcpu     = 2
      memory   = 4096  # MB
      disk     = 80    # GB
      provider = "ultravds"
      os       = "ubuntu-24.04"
    }
    
    worker = {
      name     = "${local.project_name}-worker"
      vcpu     = 1
      memory   = 1024
      disk     = 20
      provider = "justhost"
      os       = "ubuntu-24.04"
    }
  }
}

# Пример ресурса (демонстрация структуры)
resource "local_file" "infrastructure_spec" {
  filename = "${path.module}/infrastructure.json"
  content = jsonencode({
    project     = local.project_name
    environment = local.environment
    servers     = local.servers
    created_at  = timestamp()
  })
}

output "summary" {
  description = "Infrastructure summary"
  value = {
    total_servers   = length(local.servers)
    total_ram_gb    = sum([for s in local.servers : s.memory]) / 1024
    total_disk_gb   = sum([for s in local.servers : s.disk])
    master_provider = local.servers.master.provider
    worker_provider = local.servers.worker.provider
  }
}
