output "server_ipv6s" {
  value       = hcloud_server.this[*].ipv6_address
  description = "List of server IPv6 addresses."
}

output "server_names" {
  value = hcloud_server.this[*].name
}