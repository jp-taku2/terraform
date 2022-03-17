module "fargate" {
  source = "../modules/eks/fargate"

  cluster_name       = module.eks-cluster.eks-cluster.name
  fargate_name       = "sand-box-fargate"
  cluster_role_arn   = data.terraform_remote_state.iam.outputs.eks-fargate-role.arn
  fargate-subnet_ids = local.fargate-subnet_ids
}