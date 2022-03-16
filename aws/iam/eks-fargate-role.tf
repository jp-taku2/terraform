resource "aws_iam_role" "eks-fargate" {
  assume_role_policy = data.aws_iam_policy_document.eks-fargate.json
  name = "eks-fargate"
}

resource "aws_iam_role_policy_attachment" "eks-cluster-AmazonEKSFargatePodExecutionRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role = aws_iam_role.eks-cluster.name
}

data "aws_iam_policy_document" "eks-fargate" {
  statement {
    effect = "Allow"
    principals {
      identifiers = [
        "eks-fargate-pods.amazonaws.com",
      ]
      type = "Service"
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}

