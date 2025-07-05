resource "azurerm_subnet" "firewall_subnet" {
  name                 = local.firewall_subnet
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "firewall_pip" {
  name                = local.pip_name
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}

resource "azurerm_firewall" "firewall" {
  name                = local.firewall_name
  location            = var.location
  resource_group_name = var.rg_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.firewall_pip.id
  }

  tags = var.tags
}

resource "azurerm_route_table" "rt" {
  name                = local.rt_name
  location            = var.location
  resource_group_name = var.rg_name

  route {
    name                   = "force-tunnel"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
  }

  tags = var.tags
}

resource "azurerm_subnet_route_table_association" "aks_subnet_assocciation" {
  subnet_id      = data.azurerm_subnet.aks.id
  route_table_id = azurerm_route_table.rt.id
}

data "azurerm_subnet" "aks" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}

resource "azurerm_firewall_application_rule_collection" "app_rule" {
  name                = local.app_rule_name
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = var.rg_name
  priority            = 100
  action              = "Allow"

  rule {
    name = "AllowHTTP"

    source_addresses = ["*"]

    protocol {
      type = "Http"
      port = 80
    }
    target_fqdns = ["www.microsoft.com"]
  }
}

resource "azurerm_firewall_network_rule_collection" "net_rule" {
  name                = local.net_rule_name
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = var.rg_name
  priority            = 200
  action              = "Allow"

  rule {
    name                  = "AllowDNS"
    source_addresses      = ["*"]
    destination_addresses = ["*"]
    destination_ports     = ["53"]
    protocols             = ["UDP"]
  }
}

resource "azurerm_firewall_nat_rule_collection" "nat_rule" {
  name                = local.nat_rule_name
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = var.rg_name
  priority            = 300
  action              = "Dnat"

  rule {
    name                  = "NGINXDNAT"
    source_addresses      = ["*"]
    destination_ports     = ["80"]
    destination_addresses = [azurerm_public_ip.firewall_pip.ip_address]
    protocols             = ["TCP"]
    translated_address    = var.aks_lb_ip
    translated_port       = "80"
  }
}