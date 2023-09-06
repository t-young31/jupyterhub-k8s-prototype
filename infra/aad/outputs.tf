output "client_id" {
  value     = azuread_application.api.application_id
  sensitive = true
}

output "client_secret" {
  value     = azuread_application_password.api.value
  sensitive = true
}

output "tenant_id" {
  value     = data.azuread_client_config.current.tenant_id
  sensitive = true
}
