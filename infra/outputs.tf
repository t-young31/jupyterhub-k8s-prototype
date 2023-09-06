output "ssh_command" {
  value = local.ssh_command
}

output "ssh_host" {
  value = local.ssh_host
}

output "ssh_args" {
  value = local.ssh_args
}

output "jupyterhub_url" {
  value = "https://${module.cloudflare.fqdn}"
}
