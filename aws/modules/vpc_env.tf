variable "vpc_name" {
  type = "list"
  default = [
    "prod-vpc"
  ]
}

variable "vpc_cidr" {
  type = "map"
  default = {
    prod-vpc = "10.1.0.0/16"
  }
}

variable "prod-subnet_name-public" {
  type = "list"
  default = [
    "prod-public-a",
    "prod-public-c"
  ]
}

variable "prod-subnet_name-internal" {
  type = "list"
  default = [
    "prod-internal-a",
    "prod-internal-c"
  ]
}

variable "stg-subnet_name" {
  type = "list"
  default = [
  ]
}

variable "dev-subnet_name" {
  type = "list"
  default = [
  ]
}

variable "prod-subnet_cidr-public" {
  type = "map"
  default = {
    prod-public-a = "10.1.0.0/22"
    prod-public-c = "10.1.4.0/22"
  }
}

variable "prod-subnet_cidr-internal" {
  type = "map"
  default = {
    prod-internal-a = "10.1.8.0/22"
    prod-internal-c = "10.1.12.0/22"
  }
}

variable "prod-subnet_az-public" {
  type = "map"
  default = {
    prod-public-a = "ap-northeast-1a"
    prod-public-c = "ap-northeast-1c"
  }
}

variable "prod-subnet_az-internal" {
  type = "map"
  default = {
    prod-internal-a = "ap-northeast-1a"
    prod-internal-c = "ap-northeast-1c"
  }
}

variable "igw_name" {
  type = "list"
  default = [
    "prod-retty-internet-gateway"
  ]
}