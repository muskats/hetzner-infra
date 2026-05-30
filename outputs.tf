output "servers" {
  value = [
    for idx, ip in module.instance.server_ipv6s : {
      name = "node-${idx}"
      ipv6 = ip
      role = idx == 0 ? "control-plane" : "worker"
    }
  ]
}
