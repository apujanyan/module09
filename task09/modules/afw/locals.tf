locals {
  firewall_name         = join("-", [var.name_prefix, "afw"])
  pip_name              = join("-", [var.name_prefix, "pip"])
  rt_name               = join("-", [var.name_prefix, "rt"])
  app_rule_name         = join("-", [var.name_prefix, "rule-app"])
  net_rule_name         = join("-", [var.name_prefix, "rule-net"])
  nat_rule_name         = join("-", [var.name_prefix, "rule-nat"])
  firewall_subnet       = "AzureFirewallSubnet"
  afw_public_ip_address = azurerm_public_ip.firewall_pip.ip_address
  nat_rules = [
    {
      name                  = "NGINXDNAT"
      source_addresses      = ["*"]
      destination_ports     = ["80"]
      destination_addresses = [local.afw_public_ip_address]
      protocols             = ["TCP"]
      translated_address    = var.aks_lb_ip
      translated_port       = "80"
    }
  ]
  net_rules = [
    {
      name                  = "AllowDNS"
      source_addresses      = ["*"]
      destination_addresses = ["*"]
      destination_ports     = ["53"]
      protocols             = ["UDP"]
    }
  ]
  app_rules = [
    {
      name             = "AllowHTTP"
      source_addresses = ["*"]
      protocols = [
        {
          type = "Http"
          port = 80
        }
      ]
      target_fqdns = ["www.microsoft.com"]
    }
  ]
}