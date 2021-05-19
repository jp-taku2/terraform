terraform {
  required_version = "0.15.3"
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "jp_taku2"

    workspaces {
      name = "terraform-aws-iam"
    }
  }
}
