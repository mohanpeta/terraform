
# EKS Module

## Overview

This module creates production-grade EKS clusters with:

- Multiple clusters support
- Multiple node groups per cluster
- Launch templates
- AWS-managed add-ons
- KMS encryption
- IAM-based access control
- Secure networking

---

## Features

### Clusters
- Multi-cluster support using `for_each`
- API + ConfigMap authentication
- Cluster logging enabled
- KMS encryption for secrets

### Node Groups
- Managed node groups
- Spot + On-Demand support
- Taints and labels support
- Auto scaling

### Security
- IMDSv2 enforced
- KMS encryption enabled
- IAM-based access (Access Entries)

---

## Inputs

| Variable | Description |
|----------|------------|
| clusters | Map of EKS clusters |
| cluster_role_arn | IAM role for EKS control plane |
| node_role_arn | IAM role for worker nodes |
| kms_key_arn | KMS key for encryption |
| private_subnet_ids | Subnets for nodes |

---

## Outputs

- cluster_names
- cluster_endpoints
- cluster_arns
- node_group_ids
- oidc_provider_urls

---

## Usage Example

```hcl
module "eks" {
  source = "../../modules/eks"

  environment = "dev"

  cluster_role_arn = module.iam.cluster_role_arn
  node_role_arn    = module.iam.node_role_arn

  kms_key_arn = module.kms.kms_key_arn

  private_subnet_ids = module.vpc.private_subnets

  clusters = var.clusters
}
