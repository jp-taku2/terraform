provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_iam_user" "jp_taku2" {
  name = "jp_taku2"
  path = "/admin/"

  tags = {
    tag-key = ""
  }
}

data "aws_iam_policy_document" "sandbox-powe-user" {
  statement {
    sid    = "AllowSandboxPoweUser"
    effect = "Allow"
    actions = [
      "iam:CreateServiceLinkedRole",
      "iam:DeleteServiceLinkedRole",
      "iam:ListRoles",
      "organizations:DescribeOrganization",
      "account:ListRegions"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    sid    = "SandboxPoweUserNotAction"
    effect = "Allow"
    not_actions = [
      "organizations:*",
      "account:*"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_user_policy" "power-user" {
  name   = "power-user"
  user   = aws_iam_user.jp_taku2.name
  policy = data.aws_iam_policy_document.sandbox-powe-user.json
}
