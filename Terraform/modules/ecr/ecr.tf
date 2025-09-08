# -------------------
# ECR Repository
# -------------------

resource "aws_ecr_repository" "app" {
  name = "${var.project_name}-app"

  image_scanning_configuration {
    scan_on_push = var.ecr_scan_on_push
  }

  tags = var.common_tags
}

# --------------------------------
# ECR Repository Lifecycle Policy
# --------------------------------

resource "aws_ecr_lifecycle_policy" "lifecycle_policy" {
  repository = aws_ecr_repository.app.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 14 days",
            "selection": {
                "tagStatus": "any",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 14
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
