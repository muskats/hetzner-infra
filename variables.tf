variable "HCLOUD_TOKEN" {
  type        = string
  description = "Hetzner Cloud API token."
  sensitive   = true
}

variable "HCLOUD_SSH_PUBLIC" {
  type        = string
  description = "SSH public key."
}

variable "location" {
  type    = string
  default = "hel1"
}

variable "instance_type" {
  type    = string
  default = "cx23"
}

variable "image" {
  type    = string
  default = "debian-13"
}

variable "instance_count" {
  type    = number
  default = 3
}

variable "ipv4_enabled" {
  type    = bool
  default = true
}

variable "ipv6_enabled" {
  type    = bool
  default = true
}

variable "network_name" {
  type    = string
  default = "k8s-network"
}

variable "network_id" {
  type    = number
  default = null
}
variable "ip_range" {
  type    = string
  default = "10.0.0.0/16"
}

variable "network_zone" {
  type    = string
  default = "eu-central"
}

variable "subnet_ip_range" {
  type    = string
  default = "10.0.1.0/24"
}

variable "K3_TOKEN" {
  type      = string
  sensitive = true
}

variable "tailscale_auth_key" {
  type      = string
  sensitive = true
}
