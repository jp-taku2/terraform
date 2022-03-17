data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket                  = "jp-taku2-sandbox"
    key                     = "terraform/vpc.tfstate"
    region                  = "ap-northeast-1"
    shared_credentials_file = "~/.aws/credentials"
    profile                 = "sand-box"
  }
}

data "terraform_remote_state" "iam" {
  backend = "s3"
  config = {
    bucket                  = "jp-taku2-sandbox"
    key                     = "terraform/iam.tfstate"
    region                  = "ap-northeast-1"
    shared_credentials_file = "~/.aws/credentials"
    profile                 = "sand-box"
  }
}