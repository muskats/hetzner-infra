output "server_ipv4s" {
  value = [
    for idx, ip in module.instance.server_ipv4s : {
      name = "node-${idx}"
      ipv4 = ip
      role = idx == 0 ? "control-plane" : "worker"
    }
  ]
}

output "server_ipv6s" {
  value = [
    for idx, ip in module.instance.server_ipv6s : {
      name = "node-${idx}"
      ipv6 = ip
      role = idx == 0 ? "control-plane" : "worker"
    }
  ]
}
#