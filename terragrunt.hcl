locals {
  project_name = basename(dirname(get_terragrunt_dir()))
  environment_name = basename(get_terragrunt_dir())
}

remote_state {
  backend = "azurerm"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    tenant_id            = "" # DO NOT DELETE! While these values dont do anything in terraform unless you're using a managed identity, we store them for dso internal use.
    resource_group_name  = "dso-terraform-state"
    storage_account_name = "azure${local.environment_name }"
    key                  = "${local.project_name}/${local.project_name}-${local.environment_name}.tfstate"
    container_name       = local.project_name
  }
}
terraform {
before_hook "before_hook_vm" {
  commands = ["apply", "plan", "destroy"]
  execute = ["bash", "-c", "az vm list --query '[].{name:name, id:id}' > .vmlist"]
  run_on_error = true
}
before_hook "before_hook_sa" {
  commands = ["apply", "plan", "destroy"]
  execute = ["bash", "-c", "az storage account list --query '[].{name:name, id:id}' > .salist"]
  run_on_error = true
}
}
