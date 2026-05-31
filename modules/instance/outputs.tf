output "server_ids" {
  value = hcloud_server.this[*].id
}

output "server_names" {
  value = hcloud_server.this[*].name
}

output "ipv4_addresses" {
  value = hcloud_server.this[*].ipv4_address
}

output "ipv6_addresses" {
  value = hcloud_server.this[*].ipv6_address
}

output "private_ips" {
  value = hcloud_server_network.this[*].ip
}