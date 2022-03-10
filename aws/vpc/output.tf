output "vpc" {
  value = module.vpc.vpc
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "apps_subnet_ids" {
  value = {
    apps-1a = module.vpc.private_subnets.apps-1a,
    apps-1c = module.vpc.private_subnets.apps-1c,
    apps-1d = module.vpc.private_subnets.apps-1d
  }
}