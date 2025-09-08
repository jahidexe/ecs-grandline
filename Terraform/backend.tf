terraform {
  backend "s3" {
    bucket         = "ecs-grand-line-backen"
    key            = "dev/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
