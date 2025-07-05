output "azure_firewall_public_ip" {
  description = "Azure Firewall public IP."
  value       = module.afw.afw_public_ip
}

output "azure_firewall_private_ip" {
  description = "Azure Firewall private IP."
  value       = module.afw.afw_private_ip
}