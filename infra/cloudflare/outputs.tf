output "fqdn" {
  value = "${cloudflare_record.jupyter.name}.${data.cloudflare_zone.base.name}"
}
