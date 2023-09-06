terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.7.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "3.4.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.11.0"
    }
  }

  required_version = ">=1.2.0"
}

provider "aws" {
  region = var.aws_region
}

provider "helm" {
  kubernetes {
    config_path = local.kube_config_path
  }
}
