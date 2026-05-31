locals {
  node_private_ips = [
    for i in range(var.instance_count) : cidrhost(var.subnet_ip_range, i + 10)
  ]
}