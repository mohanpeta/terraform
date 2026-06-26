# S3 Bucket

resource "aws_s3_bucket" "state" {
  bucket        = local.bucket_name
  force_destroy = var.enable_force_destroy
}


# versioning

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.state.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}

# Encryption

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


# Public Access Block

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


# Life Cycle policy

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.state.id

  rule {
    id     = "terraform-state-retention"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = var.retention_days
    }
  }
}


# Dynamo DB Lock Table

resource "aws_dynamodb_table" "lock" {
  name         = var.lock_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }
}



