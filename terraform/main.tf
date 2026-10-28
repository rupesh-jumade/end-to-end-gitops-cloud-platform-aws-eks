terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

module "networking" {
  source = "./modules/networking"

  project_name       = "end-to-end-gitops-cloud-platform"
  environment        = "dev"
  availability_zones = slice(data.aws_availability_zones.available.names, 0, 2)

  # Private EKS worker nodes need outbound connectivity.
  # This creates a billable NAT Gateway when applied.
  enable_nat_gateway = true

  tags = local.common_tags
}

module "ecr" {
  source = "./modules/ecr"

  project_name = "end-to-end-gitops-cloud-platform"
  environment  = "dev"

  tags = local.common_tags
}

module "iam" {
  source = "./modules/iam"

  project_name = "end-to-end-gitops-cloud-platform"
  environment  = "dev"

  tags = local.common_tags
}

module "eks" {
  source = "./modules/eks"

  project_name       = "end-to-end-gitops-cloud-platform"
  environment        = "dev"
  kubernetes_version = "1.36"

  private_subnet_ids = module.networking.private_subnet_ids
  cluster_role_arn   = module.iam.eks_cluster_role_arn
  node_role_arn      = module.iam.eks_node_role_arn

  # Restrict Kubernetes API access to your current public IPv4.
  cluster_endpoint_public_access_cidrs = ["152.56.10.10/32"]

  # Start with one node to control spending.
  instance_types = ["t3.medium"]
  desired_size   = 1
  min_size       = 1
  max_size       = 1

  tags = local.common_tags

  # Ensure networking and IAM resources are ready first.
  depends_on = [
    module.networking,
    module.iam
  ]
}
