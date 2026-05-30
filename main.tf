module "ssh" {
  source = "./modules/ssh"
  pubkey = var.HCLOUD_SSH_PUBLIC

  providers = {
    hcloud = hcloud
  }
}

module "instance" {
  source         = "./modules/instance"
  instance_count = var.instance_count
  server_type    = var.instance_type
  ipv4_enabled   = var.ipv4_enabled
  ipv6_enabled   = var.ipv6_enabled
  location       = var.location
  ssh_key_name   = module.ssh.ssh_key_name
  image          = var.image

  providers = {
    hcloud = hcloud
  }
}

