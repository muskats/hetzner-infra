module "ssh" {
  source = "./modules/ssh"
  pubkey = var.HCLOUD_SSH_PUBLIC

  providers = {
    hcloud = hcloud
  }
}

module "network" {
  source = "./modules/network"

  name            = var.network_name
  ip_range        = var.ip_range
  subnet_ip_range = var.subnet_ip_range
  network_zone    = var.network_zone

  providers = {
    hcloud = hcloud
  }
}

module "instance" {
  source               = "./modules/instance"
  image                = var.image
  location             = var.location
  instance_count       = var.instance_count
  server_type          = var.instance_type
  ipv4_enabled         = var.ipv4_enabled
  ipv6_enabled         = var.ipv6_enabled
  network_id           = module.network.id
  private_network_cidr = var.subnet_ip_range
  ssh_key_name         = module.ssh.ssh_key_name
  user_data_per_node   = module.cloudinit.user_data
  private_ips          = local.node_private_ips

  providers = {
    hcloud = hcloud
  }
}

module "cloudinit" {
  source             = "./modules/cloudinit"
  private_ips        = local.node_private_ips
  cluster_token      = var.K3_TOKEN
  private_interface  = "eth1"
  tailscale_auth_key = var.tailscale_auth_key
}

