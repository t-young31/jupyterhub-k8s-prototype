data "cloudflare_zone" "base" {
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_record" "jupyter" {
  zone_id = var.cloudflare_zone_id
  name    = "jupyter"
  value   = var.server_public_ip
  type    = "A"
  proxied = false
}
