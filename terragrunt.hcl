locals {
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  # Extract the variables we need for easy access
  vsphere_server   = local.region_vars.locals.vsphere_server
}

remote_state {
  backend = "local"
  config = {
    path = "${get_terragrunt_dir()}/state/terraform.tfstate"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "vsphere" {
  vsphere_server = "${local.vsphere_server}"
  allow_unverified_ssl = true
}
EOF
}

inputs = merge(
  local.region_vars.locals
)
