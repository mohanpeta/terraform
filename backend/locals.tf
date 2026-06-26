
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

locals {
  bucket_name = "${var.state_bucket_name}-${var.environment}-${random_string.suffix.result}"
}
