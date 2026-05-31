locals {
  server_ip = var.private_ips[0]

  user_data = [
    for i, ip in var.private_ips : i == 0 ?
    templatefile("${path.root}/templates/cloud-init/k3s-server.yaml.tftpl", {
      node_ip           = ip
      private_interface = var.private_interface
      k3s_version       = var.k3s_version
      cluster_token     = var.cluster_token
    }) :
    templatefile("${path.root}/templates/cloud-init/k3s-agent.yaml.tftpl", {
      node_ip           = ip
      server_ip         = local.server_ip
      private_interface = var.private_interface
      k3s_version       = var.k3s_version
      cluster_token     = var.cluster_token
    })
  ]
}
