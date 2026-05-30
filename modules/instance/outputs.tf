output "server_ipv4s" {
  value       = hcloud_server.this[*].ipv4_address
  description = "List of server IPv4 addresses."
}

output "server_names" {
  value = hcloud_server.this[*].name
}