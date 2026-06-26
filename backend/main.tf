resource "aws_s3_bucket" "state" {
  bucket        = local.bucket_name
  force_destroy = var.enable_force_destroy
}

