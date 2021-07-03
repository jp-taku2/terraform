terraform {
  required_version = "1.0.1"
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