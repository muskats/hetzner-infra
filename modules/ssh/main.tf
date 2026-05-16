resource "hcloud_ssh_key" "this" {
  name       = "infra-ssh-key"
  public_key = var.pubkey
}
