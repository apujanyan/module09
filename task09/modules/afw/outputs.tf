output "afw_public_ip" {
  description = "Azure Firewall Public IP."
  value       = azurerm_public_ip.firewall_pip.ip_address
}

output "afw_private_ip" {
  description = "Azure Firewall Private IP."
  value       = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
}
