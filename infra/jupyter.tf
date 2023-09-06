resource "helm_release" "jupyterhub" {
  name       = "jupyterhub"
  repository = "https://hub.jupyter.org/helm-chart/"
  chart      = "jupyterhub"
  version    = "3.0.3"

  depends_on = [
    null_resource.get_kubeconfig,
    aws_security_group_rule.all_ingress_from_deployers_ip
  ]
}
