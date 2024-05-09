resource "aws_iam_role" "LambdaEC2Role" {
  name = "LambdaEC2Role"
  assume_role_policy = jsonencode({
    Version : "2012-10-17"
    Statement : [
      {
        Effect : "Allow"
        Principal : {
          "Service" : "lambda.amazonaws.com"
        }
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

#resource "aws_iam_role_policy_attachment" "lambda_role_policy_attachment" {
#  role       = aws_iam_role.lambdaEC2Role.name
#  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"  #might be an issue
#}

resource "aws_iam_policy" "lambda_policy" {
  name        = "start_stop_instances"
  description = "Policy to start and stop EC2 instances"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:StartInstances",
          "ec2:StopInstances",
          "ec2:DescribeInstances",
          "ec2:RunInstances",
          "ec2:TerminateInstances",
          "ec2:CreateTags"
        ]
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_policy_attachment" "lambda_policy_attachment" {
  name       = "lambda_StartandStop_instances_attachment"
  roles      = [aws_iam_role.LambdaEC2Role.name]
  policy_arn = aws_iam_policy.lambda_policy.arn
}

