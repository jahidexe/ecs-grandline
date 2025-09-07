output "github_oidc_role_arn" {
  value = aws_iam_role.github_oidc_role.arn
}

output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}
