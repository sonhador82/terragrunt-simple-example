include "root" {
  path = find_in_parent_folders()
}

include "envcommon" {
  path = "${dirname(find_in_parent_folders())}/_common/file.hcl"
}

inputs = {
  instance_count = 5
}
