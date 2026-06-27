# IRSA Module

## Purpose

Creates IAM roles for Kubernetes service accounts using OIDC federation.

---

## Why IRSA?

Without IRSA:
- All pods use node IAM role ❌
- Over-permission risk ❌

With IRSA:
- Each pod gets its own IAM role ✅
- Least privilege security ✅
- Production-grade AWS integration ✅

---

## Inputs

- cluster_name
- oidc_provider_arn
- oidc_provider_url
- irsa_roles

---

## Example Usage

```hcl
module "irsa" {
  source = "../../modules/irsa"

  cluster_name        = module.eks.cluster_names[0]
  oidc_provider_arn   = module.oidc.oidc_provider_arns["dev"]
  oidc_provider_url   = module.oidc.oidc_provider_urls["dev"]

  irsa_roles = {
    "external-dns" = {
      namespace       = "kube-system"
      service_account = "external-dns"
      policy_arns     = ["arn:aws:iam::aws:policy/AmazonRoute53FullAccess"]
    }
  }
}
