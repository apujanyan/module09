module "afw" {
  source       = "./modules/afw"
  name_prefix  = var.name_prefix
  location     = var.location
  rg_name      = local.rg_name
  vnet_name    = local.vnet_name
  subnet_name  = var.subnet_name
  subnet_space = var.subnet_space
  aks_lb_ip    = var.aks_loadbalancer_ip

  tags = var.tags
}