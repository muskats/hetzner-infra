resource "hcloud_server" "this" {
  count       = var.instance_count
  name        = "node-${count.index}"
  server_type = var.server_type
  image       = var.image
  location    = var.location
  ssh_keys    = [var.ssh_key_name]
  user_data   = file("${path.module}/../../templates/cloud-init/os-hardening.tpl")
}
