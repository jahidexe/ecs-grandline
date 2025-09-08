terraform {
  backend "s3" {
    bucket         = "ecs-grand-line-backen"
    key            = "infra/terraform.tfstate"
    region         = var.region
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
