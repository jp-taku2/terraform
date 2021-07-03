module "vpc" {
  source = "../modules/vpc"

  ## vpc parameter
  cidr = "10.1.0.0/16"

  ## subnet parameter
  azs = [
    "ap-northeast-1a",
    "ap-northeast-1c",
    "ap-northeast-1d",
  ]

  public_subnets = {
    dmz-1a = {
      cidr = "10.1.1.0/26"
      az   = "ap-northeast-1a"
    },
    dmz-1c = {
      cidr = "10.1.1.64/26"
      az   = "ap-northeast-1c"
    },
    dmz-1d = {
      cidr = "10.1.1.128/26"
      az   = "ap-northeast-1d"
    },
  }

  private_subnets = {
    apps-1a = {
      cidr          = "10.16.0.0/24"
      az            = "ap-northeast-1a"
      map_public_ip = true
    },
    apps-1c = {
      cidr          = "10.17.0.0/24"
      az            = "ap-northeast-1c"
      map_public_ip = true
    },
    apps-1d = {
      cidr          = "10.18.0.0/24"
      az            = "ap-northeast-1d"
      map_public_ip = true
    },
    serverless-1a = {
      cidr          = "10.19.0.0/24"
      az            = "ap-northeast-1a"
      map_public_ip = false
    },
    serverless-1c = {
      cidr          = "10.20.0.0/24"
      az            = "ap-northeast-1c"
      map_public_ip = false
    },
    serverless-1d = {
      cidr          = "10.21.0.0/24"
      az            = "ap-northeast-1d"
      map_public_ip = false
    },
  }
}