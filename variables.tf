variable "HCLOUD_TOKEN" {
  type        = string
  description = "Hetzner Cloud API token (Terraform Cloud variable)"
  sensitive   = true
}

variable "HCLOUD_SSH_PUBLIC" {
  type        = string
  description = "SSH public key. (Terraform Cloud variable)"
}

variable "HCLOUD_SSH_PRIVATE" {
  type        = string
  description = "SSH private key. (Terraform Cloud variable)"
  sensitive   = true
}

variable "location" {
  type    = string
  default = "hil"
}

variable "instance_type" {
  type    = string
  default = "cpx22"
}

variable "image" {
  type    = string
  default = "debian-13"
}

variable "instance_count" {
  type    = number
  default = 3
}

