resource "aws_iam_role" "this" {
  name = "eks-cluster"
  assume_role_policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role_policy_attachment" "this-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.this.name
}

resource "aws_iam_role_policy_attachment" "this-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role = aws_iam_role.this.name
}

data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"
    principals {
      identifiers = [
        "eks.amazonaws.com"
      ]
      type = "Service"
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name = "/aws/eks/example/cluster"
  retention_in_days = 7
}


data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "jp-taku2-sandbox"
    key    = "terraform/vpc.tfstate"
    region = "ap-northeast-1"
    shared_credentials_file = "~/.aws/credentials"
    profile                 = "sand-box"
  }
}

locals {
  subnet_ids = [
    data.terraform_remote_state.vpc.outputs.apps_subnet_ids.apps-1a.id,
    data.terraform_remote_state.vpc.outputs.apps_subnet_ids.apps-1c.id,
    data.terraform_remote_state.vpc.outputs.apps_subnet_ids.apps-1d.id,
  ]
}

resource "aws_eks_cluster" "this" {
  name = "example"
  role_arn = aws_iam_role.this.arn
  vpc_config {
    subnet_ids = local.subnet_ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.this-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.this-AmazonEKSVPCResourceController,
    aws_cloudwatch_log_group.this
  ]

}