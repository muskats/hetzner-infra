resource "hcloud_server" "this" {
  count       = var.instance_count
  name        = "node-${count.index}"
  server_type = var.server_type
  public_net {
    ipv4_enabled = var.ipv4_enabled
    ipv6_enabled = var.ipv6_enabled
  }
  image     = var.image
  location  = var.location
  ssh_keys  = [var.ssh_key_name]
  user_data = file("${path.module}/../../templates/cloud-init/os-hardening.tpl")
}
