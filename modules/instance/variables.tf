variable "instance_count" {
  type = number
}

variable "server_type" {
  type = string
}

variable "location" {
  type = string
}

variable "ssh_key_name" {
  type = string
}

variable "image" {
  type = string
}

variable "ipv4_enabled" {
  type = bool
}

variable "ipv6_enabled" {
  type = bool
}