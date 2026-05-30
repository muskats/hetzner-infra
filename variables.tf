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