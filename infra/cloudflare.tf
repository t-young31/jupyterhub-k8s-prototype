module "cloudflare" {
  source = "./cloudflare"

  server_public_ip   = aws_instance.server.public_ip
  cloudflare_zone_id = var.cloudflare_zone_id
}
