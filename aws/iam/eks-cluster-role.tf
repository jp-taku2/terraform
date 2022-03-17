resource "aws_iam_role" "eks-cluster" {
  name               = "eks-cluster"
  assume_role_policy = data.aws_iam_policy_document.eks-cluster.json
}

resource "aws_iam_role_policy_attachment" "eks-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster.name
}

resource "aws_iam_role_policy_attachment" "eks-cluster-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks-cluster.name
}

data "aws_iam_policy_document" "eks-cluster" {
  statement {
    effect = "Allow"
    principals {
      identifiers = [
        "eks.amazonaws.com",
        "eks-fargate-pods.amazonaws.com",
      ]
      type = "Service"
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}

