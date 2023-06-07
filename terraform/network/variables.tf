variable "name_prefix" {
  type        = string
  description = "Prefix name network and subnets"
}

variable "network_name" {
  type        = string
  description = "Name VPC network"
}

variable "labels" {
  type        = map(string)
  description = "Labels to add to resources"
}

variable "vps_subnetworks" {
  type = map(list(string))
  description = "Subnets in Availability Zones"
}

#variable "az" {
#  type = list(string)
#  description = "Availability Zones"
#}
#
#variable "cidr_blocks" {
#  type        = list(list(string))
#  description = "List of lists of IPv4 CIDR blocks for subnets"
#}




