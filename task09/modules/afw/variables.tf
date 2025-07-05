variable "name_prefix" {
  description = "Name prefix for resources."
  type        = string
}

variable "location" {
  description = "Location."
  type        = string
}

variable "rg_name" {
  description = "Resource group."
  type        = string
}

variable "vnet_name" {
  description = "VNet name."
  type        = string
}

variable "subnet_name" {
  description = "Subnet name."
  type        = string
}

variable "subnet_space" {
  description = "Subnet space."
  type        = string
}

variable "aks_lb_ip" {
  description = "AKS LB IP."
  type        = string
}

variable "tags" {
  description = "Tags for resources."
  type        = map(string)
}