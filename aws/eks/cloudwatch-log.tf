resource "aws_cloudwatch_log_group" "eks" {
  name = "/aws/eks/example/cluster"
  retention_in_days = 7
}
