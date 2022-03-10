terraform {
  required_version = "1.1.7"
  backend "s3" {
    bucket = "jp-taku2-sandbox"
    key    = "terraform/iam.tfstate"
    region = "ap-northeast-1"
    shared_credentials_file = "~/.aws/credentials"
    profile                 = "sand-box"
  }
}

