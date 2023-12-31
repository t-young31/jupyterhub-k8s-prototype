locals {
  ec2_username = "ec2-user"
  ssh_key_name = "ec2_id_rsa"

  k3s_version = "v1.27.3+k3s1"

  kube_config_path = "${path.module}/../kube_config.yaml"

  ssh_key_path = "${path.module}/../${local.ssh_key_name}"
  ssh_args     = "-i ${local.ssh_key_name}"
  ssh_host     = "${local.ec2_username}@${aws_instance.server.public_ip}"
  ssh_command  = "ssh ${local.ssh_args} ${local.ssh_host}"

  url                = "https://${module.cloudflare.fqdn}"
  oauth_callback_url = "${local.url}/hub/oauth_callback"

  tags = {
    Repo  = "jupyterhub-k8s-prototype"
    Owner = data.aws_caller_identity.current.arn
  }
}
