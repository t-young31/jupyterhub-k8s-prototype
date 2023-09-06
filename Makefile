SHELL := /bin/bash
.PHONY: *

define terraform-apply
	. init.sh $$ \
    echo "Running: terraform apply on $(1)" && \
    cd $(1) && \
	terraform init -upgrade && \
	terraform validate && \
	terraform apply --auto-approve
endef

define terraform-destroy
	. init.sh $$ \
    echo "Running: terraform destroy on $(1)" && \
    cd $(1) && \
	terraform apply -destroy --auto-approve
endef

all:
	$(call terraform-apply, ./infra)
	@echo "Using kubectl requires: export KUBECONFIG=kube_config.yaml"

login:
	aws configure sso

destroy:
	$(call terraform-destroy, ./infra)
