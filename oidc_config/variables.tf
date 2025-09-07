variable "github_repo" {
  description = "GitHub repo in the format <owner>/<repo>"
  type        = string
  default     = "jahidexe/ecs-grandline"
}

variable "github_branches" {
  description = "List of branches allowed to assume the role"
  type        = list(string)
  default     = ["main", "dev"]
}


variable "region" {
  description = "AWS region to deploy OIDC provider and IAM role"
  type        = string
  default     = "eu-west-1" # or your preferred region
}
