# Declare provider otherwise Terraform assumes registry.terraform.io/hashicorp/...
# Authorative version is set in root provider.tf
terraform {
  required_providers {
    hcloud = { source = "hetznercloud/hcloud" }
  }
}
