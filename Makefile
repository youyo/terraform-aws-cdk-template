.DEFAULT_GOAL := help


## bootstrap
bootstrap:
	cd cfn/ ; npx cdk bootstrap

## init
init:
	terraform init

## validate
validate:
	terraform validate

## build
build:
	-rm -rf ./cfn/function/.artifact/
	cp -a ./cfn/function/src ./cfn/function/.artifact
	pip install -r ./cfn/function/.artifact/requirements.txt -t ./cfn/function/.artifact/

## plan
plan: validate build
	terraform plan
	-cd cfn/ ; npx cdk diff

## taint
taint: validate
	terraform taint null_resource.cdk_deploy

## apply
apply: validate build
	terraform apply -auto-approve

## deploy, taint and apply
deploy: taint apply

## destroy
destroy:
	cd cfn/ ; npx cdk destroy --force
	terraform destroy -auto-approve


## help
help:
	@make2help $(MAKEFILE_LIST)


.PHONY: help
.SILENT:
