variable "private_ips" {
  type = list(string)
}

variable "cluster_token" {
  type      = string
  sensitive = true
}

variable "k3s_version" {
  type    = string
  default = "v1.30.0+k3s1"
}

variable "private_interface" {
  type    = string
  default = "eth1"
}
