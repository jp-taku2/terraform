terraform {
  required_version = "0.15.5"
  required_providers {
    aws = {
      version = "~> 3.45.0"
    }
  }
}

provider "aws" {
  region                  = "ap-northeast-1"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "sand-box"
}