locals {
  resource_name = "slurm"
#  list_subnet = flatten(values(var.vps_subnetworks))
  list_subnet = [for az, nets in var.vps_subnetworks : flatten(nets) if nets != [] ]
  list_az = flatten(tolist(keys(var.vps_subnetworks)))
}
