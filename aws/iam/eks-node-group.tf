resource "aws_iam_role" "eks_node" {
  name = "eks-node"
  assume_role_policy = data.aws_iam_policy_document.eks-node.json
}

resource "aws_iam_policy" "ebs-csi" {
  policy = data.aws_iam_policy_document.ebs-csi.json
  name = "ebs-csi-policy"
}

resource "aws_iam_role_policy_attachment" "eks_node-EbsCsi" {
  policy_arn = aws_iam_policy.ebs-csi.arn
  role = aws_iam_role.eks_node.name
}

resource "aws_iam_role_policy_attachment" "eks_node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role = aws_iam_role.eks_node.name
}

resource "aws_iam_role_policy_attachment" "eks_node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role = aws_iam_role.eks_node.name
}

resource "aws_iam_role_policy_attachment" "eks_node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role = aws_iam_role.eks_node.name
}

#resource "aws_iam_role_policy_attachment" "eks_node-PowerUserAccess" {
#  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
#  role = aws_iam_role.eks_node.name
#}


data "aws_iam_policy_document" "eks-node" {
  statement {
    effect = "Allow"
    principals {
      identifiers = [
        "ec2.amazonaws.com",
      ]
      type = "Service"
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}

data "aws_iam_policy_document" "ebs-csi" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:AttachVolume",
      "ec2:CreateSnapshot",
      "ec2:CreateTags",
      "ec2:CreateVolume",
      "ec2:DeleteSnapshot",
      "ec2:DeleteTags",
      "ec2:DeleteVolume",
      "ec2:DescribeInstances",
      "ec2:DescribeSnapshots",
      "ec2:DescribeTags",
      "ec2:DescribeVolumes",
      "ec2:DetachVolume"
    ]
    resources = "*"
  }
}