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

resource "aws_eks_cluster" "this" {
  name = "example"
  role_arn = data.terraform_remote_state.iam.outputs.eks-cluster-role.arn
  vpc_config {
    subnet_ids = local.subnet_ids
    endpoint_private_access = true
    endpoint_public_access = false
  }
  depends_on = [
    data.terraform_remote_state.iam,
    aws_cloudwatch_log_group.eks,
  ]
}