output "eks-cluster-role" {
  value = aws_iam_role.eks-cluster
}

output "eks-node-group-role" {
  value = aws_iam_role.eks_node
}

output "eks-fargate-role" {
  value = aws_iam_role.eks-fargate
}

output "eks-cluster-AmazonEKSClusterPolicy" {
  value = aws_iam_role_policy_attachment.eks-cluster-AmazonEKSClusterPolicy
}

output "eks-cluster-AmazonEKSVPCResourceController" {
  value = aws_iam_role_policy_attachment.eks-cluster-AmazonEKSVPCResourceController
}

