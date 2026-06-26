# OIDC Module

## Purpose

Creates IAM OIDC providers for EKS clusters to enable IRSA.

---

## Why this is needed

Without OIDC:

- Pods cannot assume IAM roles
- AWS Load Balancer Controller will not work
- ExternalDNS will fail
- Cluster Autoscaler cannot scale nodes securely

---

## Inputs

- clusters (map of EKS clusters with OIDC issuer URLs)

---

## Outputs

- oidc_provider_arns
- oidc_provider_urls

---

## Usage

```hcl
module "oidc" {
  source = "../../modules/oidc"

  clusters = {
    dev = {
      cluster_name    = "dev-cluster"
      oidc_issuer_url = module.eks.oidc_provider_urls["dev"]
    }
  }
}
