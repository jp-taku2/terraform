output "rg_id" {
  value = element(concat(azurerm_resource_group.this.*.id, list("")), 0)
}