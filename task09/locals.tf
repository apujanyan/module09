locals {
  rg_name          = join("-", [var.name_prefix, "rg"])
  aks_cluster_name = join("-", [var.name_prefix, "aks"])
  vnet_name        = join("-", [var.name_prefix, "vnet"])
}