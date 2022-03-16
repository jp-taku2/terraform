resource "aws_eks_node_group" "sand-box-simple" {
  cluster_name = aws_eks_cluster.this.name
  node_group_name = "sand-box-simple"
  node_role_arn = data.terraform_remote_state.iam.outputs.eks-node-group-role.arn
  subnet_ids = local.subnet_ids
  scaling_config {
    desired_size = 3
    max_size = 3
    min_size = 1
  }
  instance_types = [
    "t3.medium",
    "t3.large",
  ]
}