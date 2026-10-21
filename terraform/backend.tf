terraform {
  backend "s3" {
    bucket       = "end-to-end-gitops-aws-eks-tfstate-058862856960"
    key          = "dev/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
  }
}
