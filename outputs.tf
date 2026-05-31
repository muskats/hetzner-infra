output "control_plane_name" {
  value = module.instance.server_names[0]
}

output "control_plane_private_ip" {
  value = module.instance.private_ips[0]
}

output "worker_names" {
  value = slice(module.instance.server_names, 1, length(module.instance.server_names))
}

output "worker_private_ips" {
  value = slice(module.instance.private_ips, 1, length(module.instance.private_ips))
}

output "node_inventory" {
  value = {
    control_plane = {
      name       = module.instance.server_names[0]
      private_ip = module.instance.private_ips[0]
      ipv6       = module.instance.ipv6_addresses[0]
    }
    workers = [
      for i in range(1, length(module.instance.server_names)) : {
        name       = module.instance.server_names[i]
        private_ip = module.instance.private_ips[i]
        ipv6       = module.instance.ipv6_addresses[i]
      }
    ]
  }
}