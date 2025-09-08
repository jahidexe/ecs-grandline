terraform {
  backend "s3" {
    bucket         = "ecs-grand-line-backend"
    key            = "dev/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
