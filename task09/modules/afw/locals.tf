locals {
  firewall_name   = join("-", [var.name_prefix, "afw"])
  pip_name        = join("-", [var.name_prefix, "pip"])
  rt_name         = join("-", [var.name_prefix, "rt"])
  app_rule_name   = join("-", [var.name_prefix, "rule-app"])
  net_rule_name   = join("-", [var.name_prefix, "rule-net"])
  nat_rule_name   = join("-", [var.name_prefix, "rule-nat"])
  firewall_subnet = "AzureFirewallSubnet"
}
