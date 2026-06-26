region       = "ap-south-1"
project_name = "eks-platform"
environment  = "dev"
owner        = "platform-team"

state_bucket_name = "eks-terraform-state"
lock_table_name   = "eks-terraform-lock"

enable_force_destroy = false
enable_versioning    = true
retention_days       = 90
