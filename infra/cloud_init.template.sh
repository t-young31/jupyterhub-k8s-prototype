#!/bin/bash

cd /tmp
dnf upgrade -y

# ----------------- k3s setup --------------------------
# cloud-setup needs to be disabled for k3s
# See: https://slack-archive.rancher.com/t/10093428/would-you-expect-k3s-to-install-amp-run-on-an-aws-ec2-rhel9-
systemctl disable nm-cloud-setup.service nm-cloud-setup.timer

until curl http://169.254.169.254/latest/meta-data/public-ipv4 --connect-timeout 1; do
  sleep 5
done

public_ip="$(curl http://169.254.169.254/latest/meta-data/public-ipv4)"

# Install k3s
curl https://get.k3s.io | \
  K3S_KUBECONFIG_MODE="644" \
  INSTALL_K3S_EXEC="--cluster-cidr=172.16.0.0/16 --service-cidr=172.17.0.0/16 --disable=traefik --tls-san $public_ip" \
  INSTALL_K3S_VERSION=${k3s_version} sh -

until /usr/local/bin/kubectl get pods -A &> /dev/null; do
  sleep 5
done

# Install tools
dnf install wget make -y

# Install terraform
yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum -y install terraform

# Install helm and the jupyter repository
wget https://get.helm.sh/helm-v3.12.3-linux-amd64.tar.gz -O helm.tar.gz
tar -zxvf helm.tar.gz
mv linux-amd64/helm /usr/local/bin/helm
rm -rf helm.tar.gz

helm repo add jupyterhub https://hub.jupyter.org/helm-chart/
helm repo update
