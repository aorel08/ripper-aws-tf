terraform {
  required_version = "~> 1.0.3" # which means ">= 0.12.24" and "< 0.13"
  backend "s3" {}
  required_providers {
    aws        = "~> 4.3.0"
    kubernetes = "~> 2.8.0"
    random     = "~> 3.1.0"
    helm       = "~> 2.4.1"
    local      = "~> 2.1.0"
  }
}
provider "aws" {
  region = var.aws_region
}


# get EKS authentication for being able to manage k8s objects from terraform
provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  # load_config_file       = false
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster.token
    # load_config_file       = false
  }
}

data "aws_caller_identity" "current" {} # used for accesing Account ID and ARN
