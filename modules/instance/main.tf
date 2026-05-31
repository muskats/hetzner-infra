resource "hcloud_server" "this" {
  count       = var.instance_count
  name        = count.index == 0 ? "node" : "worker${count.index - 1}"
  server_type = var.server_type

  public_net {
    ipv4_enabled = var.ipv4_enabled
    ipv6_enabled = var.ipv6_enabled
  }

  image     = var.image
  location  = var.location
  ssh_keys  = [var.ssh_key_name]
  user_data = var.user_data_per_node[count.index]
}

resource "hcloud_server_network" "this" {
  count = var.instance_count

  server_id  = hcloud_server.this[count.index].id
  network_id = var.network_id

  ip = var.private_ips[count.index]
}
