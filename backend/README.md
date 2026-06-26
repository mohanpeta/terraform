# Terraform Backend Module

## Purpose
Creates remote state backend for Terraform.

## Resources Created
- S3 bucket (state storage)
- DynamoDB table (state locking)
- Versioning enabled
- Encryption enabled
- Public access blocked
- Lifecycle retention policy

## Deploy

```bash
terraform init
terraform plan
terraform apply
