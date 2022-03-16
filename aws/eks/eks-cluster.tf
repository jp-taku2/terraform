module "eks-cluster" {
  source = "../modules/eks"

  cluster_name = "sand-box"
  cluster_role_arn = data.terraform_remote_state.iam.outputs.eks-cluster-role.arn
  subnet_ids = local.subnet_ids
}

locals {
  subnet_ids = [
    data.terraform_remote_state.vpc.outputs.apps_subnet_ids.apps-1a.id,
    data.terraform_remote_state.vpc.outputs.apps_subnet_ids.apps-1c.id,
    data.terraform_remote_state.vpc.outputs.apps_subnet_ids.apps-1d.id,
  ]

  fargate-subnet_ids = [
    data.terraform_remote_state.vpc.outputs.apps_subnet_ids.apps-1a.id,
    data.terraform_remote_state.vpc.outputs.apps_subnet_ids.apps-1c.id,
    data.terraform_remote_state.vpc.outputs.apps_subnet_ids.apps-1d.id,
  ]
}