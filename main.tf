locals {
  vm_list = jsondecode((file(".vmlist")))
  sa_list = jsondecode((file(".salist")))
}

resource "azurerm_management_lock" "vm-lock" {
  for_each   = { for vm in local.vm_list : vm.name => vm }
  name       = "vm-lock"
  scope      = each.value.id
  lock_level = "CanNotDelete"
  notes      = "All Vms are locked automatically"
}

resource "azurerm_management_lock" "storageaccount-lock" {
  for_each   = { for sa in local.sa_list : sa.name => sa }
  name       = "storageaccount-lock"
  scope      = each.value.id
  lock_level = "CanNotDelete"
  notes      = "All Storage accounts are locked automatically"
}
