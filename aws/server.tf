resource "aws_instance" "server" {
  ami           = data.aws_ami.rhel9.id
  instance_type = "t3a.xlarge"
  key_name      = aws_key_pair.ssh.key_name

  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.default.id]

  tags = merge(local.tags, {
    Name = "${var.aws_prefix}-k3s-server"
  })

  user_data = templatefile(
    "${path.module}/cloud_init.template.sh",
    {
      k3s_version = local.k3s_version
    }
  )

  root_block_device {
    volume_size = 50 # GB
    volume_type = "gp3"
  }

  lifecycle {
    ignore_changes = [user_data]
  }

  depends_on = [
    aws_security_group_rule.all_ingress_from_deployers_ip
  ]
}

resource "null_resource" "get_kubeconfig" {
  provisioner "local-exec" {
    command = join(" && ", [
      "scp -i ${local.ssh_key_path} ${local.ssh_host}:/etc/rancher/k3s/k3s.yaml ../kube_config.yaml",
      "python replace_ip_in_kubeconfig.py ../kube_config.yaml ${aws_instance.server.public_ip}"
    ])
  }

  triggers = {
    hash = md5(file("replace_ip_in_kubeconfig.py"))
  }
}
