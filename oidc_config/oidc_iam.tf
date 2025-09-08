resource "aws_iam_role" "github_oidc_role" {
  name = "${replace(var.github_repo, "/", "-")}-github-oidc-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          "StringLike" = {
            "token.actions.githubusercontent.com:sub" = [
              for branch in var.github_branches :
              "repo:${var.github_repo}:ref:refs/heads/${branch}"
            ]
          }
        }
      }
    ]
  })
}

# Existing ECR access
resource "aws_iam_role_policy_attachment" "github_ecr" {
  role       = aws_iam_role.github_oidc_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

# New policy for Terraform backend (S3 + DynamoDB)
resource "aws_iam_policy" "terraform_backend" {
  name        = "${replace(var.github_repo, "/", "-")}-tf-backend-access"
  description = "Allow Terraform to access S3 backend and DynamoDB locks"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["s3:ListBucket"],
        Resource = "arn:aws:s3:::ecs-grand-line-backend"
      },
      {
        Effect   = "Allow",
        Action   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"],
        Resource = "arn:aws:s3:::ecs-grand-line-backend/*"
      },
      {
        Effect = "Allow",
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem",
          "dynamodb:DescribeTable"
        ],
        Resource = "arn:aws:dynamodb:eu-west-1:${data.aws_caller_identity.current.account_id}:table/terraform-locks"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "github_tf_backend" {
  role       = aws_iam_role.github_oidc_role.name
  policy_arn = aws_iam_policy.terraform_backend.arn
}


