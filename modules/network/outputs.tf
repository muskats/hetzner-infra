output "id" {
  value = hcloud_network.this.id
}

output "name" {
  value = hcloud_network.this.name
}

output "ip_range" {
  value = hcloud_network.this.ip_range
}

output "subnet_id" {
  value = hcloud_network_subnet.this.id
}