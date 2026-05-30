output "servers" {
  value = [
    for i, s in hcloud_server.this : {
      name = s.name
      ipv4 = s.ipv4_address
      ipv6 = s.ipv6_address
      role = i == 0 ? "control-plane" : "worker"
    }
  ]
}

output "server_names" {
  value = hcloud_server.this[*].name
}