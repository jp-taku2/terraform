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
      tags = {
        Name = "dmz-1a"
      }
    },
    dmz-1c = {
      cidr = "10.1.1.64/26"
      az   = "ap-northeast-1c"
      tags = {
        Name = "dmz-1c"
      }
    },
    dmz-1d = {
      cidr = "10.1.1.128/26"
      az   = "ap-northeast-1d"
      tags = {
        Name = "dmz-1d"
      }
    },
  }

  private_subnets = {
    apps-1a = {
      cidr = "10.1.16.0/24"
      az   = "ap-northeast-1a"
      nat  = "dmz-1a"
      tags = {
        Name = "apps-1a"
      }
      map_public_ip = false
    },
    apps-1c = {
      cidr = "10.1.17.0/24"
      az   = "ap-northeast-1c"
      nat  = "dmz-1c"
      tags = {
        Name = "apps-1c"
      }
      map_public_ip = false
    },
    apps-1d = {
      cidr = "10.1.18.0/24"
      az   = "ap-northeast-1d"
      nat  = "dmz-1d"
      tags = {
        Name = "apps-1d"
      }
      map_public_ip = false
    },
    serverless-1a = {
      cidr = "10.1.19.0/24"
      az   = "ap-northeast-1a"
      nat  = "dmz-1a"
      tags = {
        Name = "serverless-1a"
      }
      map_public_ip = false
    },
    serverless-1c = {
      cidr = "10.1.20.0/24"
      az   = "ap-northeast-1c"
      nat  = "dmz-1c"
      tags = {
        Name = "serverless-1c"
      }
      map_public_ip = false
    },
    serverless-1d = {
      cidr = "10.1.21.0/24"
      az   = "ap-northeast-1d"
      nat  = "dmz-1d"
      tags = {
        Name = "serverless-1d"
      }
      map_public_ip = false
    },
  }
}