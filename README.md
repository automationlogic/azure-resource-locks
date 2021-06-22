# Resource locking by subscription

This terraform project allows you to lock all VMs and storage accounts in a subscription. Uses the az cli which is initiated before the apply, plan and destroy commands.

## Limitations
Due to external provider not able to deal with non-trivial json objects: https://github.com/hashicorp/terraform-provider-external/issues/2. We are loading in the vm list manually using az cli.

## Requirements

* Please check the terragrunt.hcl for version details, use tfenv or tfswitch to use the right version.
* Requires terragrunt installed, use latest
* az cli installed
* ensure you are set to the right account with `az account set --subscription <SUBSCRIPTION-ID>`


## How to

* add the tenant id in the main terragrunt hcl
* Simply cd into one of the environments and add your subscription id in the terragrunt HCL
* or create your own by replicating the existing terragrunt.hcl in the other environments.
* apply the terraform and it will lock all storage accounts and VMs


# References
AZ VM List https://docs.microsoft.com/en-us/cli/azure/vm?view=azure-cli-latest#az_vm_list

JMESPath Query:
https://docs.microsoft.com/en-us/cli/azure/query-azure-cli?view=azure-cli-latest

## Issues
If you see the error below you need to make sure you are have selected the right account with az cli
```
Failed to get existing workspaces: Error retrieving keys for Storage Account "dsoinfraazurefixngodev": storage.AccountsClient#ListKeys: Failure responding to request: StatusCode=404 -- Original Error: autorest/azure: Service returned an error. Status=404 Code="ResourceNotFound" Message="The Resource 'Microsoft.Storage/storageAccounts/dsoinfraazurefixngodev' under resource group 'dso-terraform-state' was not found. For more details please go to https://aka.ms/ARMResourceNotFoundFix"
```
