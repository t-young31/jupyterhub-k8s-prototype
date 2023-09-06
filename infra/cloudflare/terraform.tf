terraform {
  required_providers {
    # Other providers are inherited from the parent module

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.10.0"
    }
  }

  required_version = ">= 1.2.0"
}
