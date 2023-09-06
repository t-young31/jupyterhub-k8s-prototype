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

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.10.0"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = "2.41.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
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

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
