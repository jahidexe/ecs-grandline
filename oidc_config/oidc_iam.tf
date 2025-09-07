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


resource "aws_iam_role_policy_attachment" "github_ecr" {
  role       = aws_iam_role.github_oidc_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}
