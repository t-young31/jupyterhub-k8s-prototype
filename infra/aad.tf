module "aad" {
  source = "./aad"

  suffix              = var.aws_prefix
  oauth2_redirect_url = local.oauth_callback_url
}
