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

variable "network_id" {
  type    = number
  default = null
}

variable "private_network_cidr" {
  type    = string
  default = null
}

variable "user_data_per_node" {
  type = list(string)
}

variable "private_ips" {
  type = list(string)
}