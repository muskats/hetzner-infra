locals {
  server_ip = var.private_ips[0]

  flux_bootstrap_yaml = indent(6, templatefile("${path.root}/templates/cloud-init/flux-bootstrap.yaml.tftpl", {}))

  user_data = [
    for i, ip in var.private_ips : i == 0 ?
    templatefile("${path.root}/templates/cloud-init/k3s-server.yaml.tftpl", {
      node_ip             = ip
      k3s_version         = var.k3s_version
      cluster_token       = var.cluster_token
      tailscale_auth_key  = var.tailscale_auth_key
      flux_bootstrap_yaml = local.flux_bootstrap_yaml
    }) :
    templatefile("${path.root}/templates/cloud-init/k3s-agent.yaml.tftpl", {
      node_ip            = ip
      server_ip          = local.server_ip
      k3s_version        = var.k3s_version
      cluster_token      = var.cluster_token
      tailscale_auth_key = var.tailscale_auth_key
    })
  ]
}
