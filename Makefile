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
	echo "Please call a specific target!"; exit 1

login:
	aws configure sso

aws:
	$(call terraform-apply, ./aws)
	@echo "Run: export KUBECONFIG=kube_config.yaml"

aws-destroy:
	$(call terraform-destroy, ./aws)
