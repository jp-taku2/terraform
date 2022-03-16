terraform {
  required_version = "1.1.7"
  required_providers {
    aws = {
      version = "~> 4.5.0"
    }
  }
}

provider "aws" {
  region                  = "ap-northeast-1"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "sand-box"
}