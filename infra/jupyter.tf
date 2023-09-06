resource "helm_release" "jupyterhub" {
  name       = "jupyterhub"
  repository = "https://hub.jupyter.org/helm-chart/"
  chart      = "jupyterhub"
  version    = "3.0.3"

  values = [
    templatefile("config.template.yaml",
      {
        acme_email = var.acme_email
        fqdn       = module.cloudflare.fqdn
      }
    )
  ]

  depends_on = [
    aws_instance.server,
    null_resource.get_kubeconfig,
    aws_security_group_rule.all_ingress_from_deployers_ip
  ]
}
