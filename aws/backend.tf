terraform {
  required_version = ">= 0.11.0"

  backend "s3" {
    bucket = "terrafomr"
    key    = "terraform.tfstate.aws"
    region = "ap-northeast-1"
    profile = "<TARGET-ACCOUNT>"
  }
}
