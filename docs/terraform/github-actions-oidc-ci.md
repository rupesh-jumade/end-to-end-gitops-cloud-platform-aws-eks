
# Terraform CI and AWS Deployment Strategy

## Objective

Validate Terraform code automatically without requiring AWS credentials or provisioning AWS resources during routine development.

## Current Workflow

The GitHub Actions workflow is `.github/workflows/terraform.yml`.

On pushes to `main` and pull requests targeting `main`, when the configured path filters match, the workflow runs:

1. Check out the repository.
2. Set up Terraform version 1.16.1.
3. Check Terraform formatting.
4. Initialize Terraform with `-backend=false`.
5. Validate the Terraform configuration.

This workflow does not authenticate to AWS, access the remote Terraform state, generate an AWS-backed plan, or apply infrastructure changes.

## Remote Terraform State

The new project uses a dedicated S3 backend:

- Bucket: `end-to-end-gitops-aws-eks-tfstate-058862856960`
- State key: `dev/terraform.tfstate`
- Region: `ap-south-1`
- State locking: S3 lock file enabled

The backend is configured in `terraform/backend.tf`.

The old `platform-demo-app` Terraform state and IAM permissions must remain separate and unchanged.

## Planned AWS Integration

The AWS deployment workflow will be implemented separately after local development and configuration reviews are complete.

The planned integration includes:

- GitHub Actions authentication to AWS using OpenID Connect (OIDC).
- A dedicated IAM role trusted only by the new GitHub repository and intended branch or deployment environment.
- Least-privilege permissions for the required AWS operations.
- Remote-state access scoped to the new project's state bucket and state key.
- Reviewed Terraform plans before infrastructure changes.
- No automatic `terraform apply` without an explicit, reviewed deployment process.

## Security Requirements

- Do not store long-lived AWS access keys in GitHub.
- Do not reuse the old project's IAM role or state permissions.
- Do not commit Terraform plan files or state files.
- Restrict AWS permissions to the minimum required for the workflow.
- Review costs and the proposed Terraform plan before deploying AWS infrastructure.

## Current Status

Terraform formatting and validation have succeeded locally.

The current Terraform GitHub Actions workflow is validation-only. AWS OIDC authentication, remote-state access from CI, and live infrastructure deployment remain future implementation tasks.
