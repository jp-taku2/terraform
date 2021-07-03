variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  default     = "0.0.0.0/0"
}

variable "enable_classiclink" {
  description = "A boolean flag to enable/disable ClassicLink for the VPC"
  default     = false
}

variable "enable_classiclink_dns_support" {
  description = "A boolean flag to enable/disable ClassicLink DNS Support for the VPC"
  default     = false
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  default     = true
}

variable "assign_generated_ipv6_cidr_block" {
  description = "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC"
  default     = false
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  default     = "default"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "igw_tags" {
  description = "A map of tags to add to all resources for igw"
  default     = {}
}

variable "azs" {
  description = "A list of availability zones in the region"
  default     = []
}

variable "public_subnets" {
  description = "A map of public subnets inside the VPC"
  type        = map(any)
  default     = {}
  validation {
    condition = (
      length(var.public_subnets) % 3 == 0
    )
    error_message = "This variable needs to be divisible the number of availability zones."
  }
}

variable "private_subnets" {
  description = "A map of private subnets inside the VPC"
  type        = map(any)
  default     = {}
  validation {
    condition = (
      length(var.private_subnets) % 3 == 0
    )
    error_message = "This variable needs to be divisible by the number of availability zones."
  }
}