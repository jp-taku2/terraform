resource "aws_eks_fargate_profile" "sand-box" {
  cluster_name           = var.cluster_name
  fargate_profile_name   = var.fargate_name
  pod_execution_role_arn = var.cluster_role_arn
  subnet_ids             = var.fargate-subnet_ids

  selector {
    namespace = var.fargate_name
  }
}

