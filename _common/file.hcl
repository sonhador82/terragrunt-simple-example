
terraform {
  source = "git::git@github.com:sonhador82/terraform-module-for-terragrunt-sandbox.git//filemodule?ref=v0.2.0"
}

inputs = {
  global_param = "GlobalParam"
  path = "${get_terragrunt_dir()}/testfile"
  env = local.env
  region = local.region
}

locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract out common variables for reuse
  env = local.environment_vars.locals.env

  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  # Extract the variables we need for easy access
  region   = local.region_vars.locals.region
}