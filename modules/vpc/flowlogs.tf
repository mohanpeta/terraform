
resource "aws_cloudwatch_log_group" "vpc_logs" {
  count = var.enable_flow_logs ? 1 : 0

  name              = "/aws/vpc/${local.name_prefix}"
  retention_in_days = 30
}

resource "aws_iam_role" "flowlogs_role" {
  count = var.enable_flow_logs ? 1 : 0

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "vpc-flow-logs.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_flow_log" "this" {
  count = var.enable_flow_logs ? 1 : 0

  vpc_id = aws_vpc.this.id

  log_destination      = aws_cloudwatch_log_group.vpc_logs[0].arn
  log_destination_type = "cloud-watch-logs"

  traffic_type = "ALL"
}
