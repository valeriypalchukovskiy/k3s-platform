variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "region" {
  description = "Deployment region"
  type        = string
  default     = "ru-msk"
}
