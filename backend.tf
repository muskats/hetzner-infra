terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "SM_Cloud_1"
    workspaces {
      name = "hetzner-infra"
    }
  }
}