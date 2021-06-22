inputs = {
  subscription_id = ""
}
include {
  path = find_in_parent_folders()
}
terraform {
  source = "../"
}
