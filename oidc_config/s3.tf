

# S3 bucket for state
resource "aws_s3_bucket" "tf_state" {
  bucket = "ecs-grand-line-backend" # must be unique globally

  tags = {
    Name        = "terraform-state"
    Environment = "dev"
  }
}

/*  
# Enable versioning (good practice, free tier includes it if usage is small)
resource "aws_s3_bucket_versioning" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

 */

# Block public access (avoid accidental leaks)
resource "aws_s3_bucket_public_access_block" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# DynamoDB table for state locking
resource "aws_dynamodb_table" "tf_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST" # free-tier friendly
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "terraform-locks"
    Environment = "dev"
  }
}
