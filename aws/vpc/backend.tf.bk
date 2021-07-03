terraform {
  required_version = "1.0.1"
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "jp_taku2"

    workspaces {
      name = "terraform-aws-vpc"
    }
  }
}
