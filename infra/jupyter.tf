resource "helm_release" "jupyterhub" {
  name       = "jupyterhub"
  repository = "https://hub.jupyter.org/helm-chart/"
  chart      = "jupyterhub"
  version    = "3.0.3"

  values = [
    templatefile("config.template.yaml",
      {
        admin_username     = replace(var.admin_username, "+", " ")
        acme_email         = var.acme_email
        fqdn               = module.cloudflare.fqdn
        aad_client_id      = module.aad.client_id
        aad_client_secret  = module.aad.client_secret
        oauth_callback_url = local.oauth_callback_url
        aad_tenant_id      = module.aad.tenant_id
      }
    )
  ]

  depends_on = [
    aws_instance.server,
    null_resource.get_kubeconfig,
    aws_security_group_rule.all_ingress_from_deployers_ip
  ]
}
