# IAM Role for RDS Enhanced Monitoring
resource "aws_iam_role" "monitoring-IAM-Role-RDS" {

  name = "monitoring-IAM-Role-RDS"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "monitoring-IAM-Role-RDS"
  }
}