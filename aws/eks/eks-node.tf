resource "aws_eks_node_group" "sand-box" {
  cluster_name    = module.eks-cluster.eks-cluster.name
  node_group_name = "sand-box"
  node_role_arn   = data.terraform_remote_state.iam.outputs.eks-node-group-role.arn
  subnet_ids      = local.subnet_ids
  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }
}
