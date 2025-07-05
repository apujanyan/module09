variable "name_prefix" {
  description = "Name prefix for resources."
  type        = string
}

variable "location" {
  description = "Location."
  type        = string
}

variable "vnet_space" {
  description = "Virtual Network address space."
  type        = string
}

variable "subnet_name" {
  description = "AKS Subnet name."
  type        = string
}

variable "subnet_space" {
  description = "AKS Subnet address space."
  type        = string
}

variable "aks_loadbalancer_ip" {
  description = "AKS Load Balancer IP."
  type        = string
}

variable "tags" {
  description = "Tags for resources."
  type        = map(string)
}