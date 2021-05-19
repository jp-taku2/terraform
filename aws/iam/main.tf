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

resource "aws_iam_user_policy" "power-user" {
  name = "power-user"
  user = aws_iam_user.jp_taku2.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "iam:CreateServiceLinkedRole",
        "iam:DeleteServiceLinkedRole",
        "iam:ListRoles",
        "organizations:DescribeOrganization",
        "account:ListRegions"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "NotAction": [
        "iam:*",
        "organizations:*",
        "account:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
