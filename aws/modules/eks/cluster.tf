resource "aws_eks_cluster" "cluster" {
  name = var.cluster_name
  role_arn = var.cluster_role_arn
  vpc_config {
    subnet_ids = var.subnet_ids
    endpoint_private_access = true
    endpoint_public_access = true
    public_access_cidrs = ["0.0.0.0/0"]
  }
  enabled_cluster_log_types = ["api", "audit"]
  depends_on = [
    aws_cloudwatch_log_group.eks-cluster
  ]
}

resource "aws_cloudwatch_log_group" "eks-cluster" {
  name = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = 7
}
