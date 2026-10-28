output "aws_account_id" {
  description = "AWS account ID used by this deployment."
  value       = data.aws_caller_identity.current.account_id
}

output "aws_region" {
  description = "AWS region used by this deployment."
  value       = var.aws_region
}

output "vpc_id" {
  description = "ID of the project VPC."
  value       = module.networking.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets."
  value       = module.networking.private_subnet_ids
}

output "availability_zones" {
  description = "Availability Zones used by the deployment."
  value       = module.networking.availability_zones
}

output "ecr_repository_name" {
  description = "Name of the project's ECR repository."
  value       = module.ecr.repository_name
}

output "ecr_repository_url" {
  description = "URL of the project's ECR repository."
  value       = module.ecr.repository_url
}

output "eks_cluster_role_arn" {
  description = "ARN of the EKS cluster IAM role."
  value       = module.iam.eks_cluster_role_arn
}

output "eks_node_role_arn" {
  description = "ARN of the EKS worker node IAM role."
  value       = module.iam.eks_node_role_arn
}

output "eks_cluster_name" {
  description = "Name of the EKS cluster."
  value       = module.eks.cluster_name
}

output "eks_cluster_arn" {
  description = "ARN of the EKS cluster."
  value       = module.eks.cluster_arn
}

output "eks_cluster_endpoint" {
  description = "Kubernetes API endpoint of the EKS cluster."
  value       = module.eks.cluster_endpoint
}

output "eks_node_group_name" {
  description = "Name of the EKS managed node group."
  value       = module.eks.node_group_name
}

output "eks_node_group_arn" {
  description = "ARN of the EKS managed node group."
  value       = module.eks.node_group_arn
}
