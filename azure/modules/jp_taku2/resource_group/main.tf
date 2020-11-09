resource "azurerm_resource_group" "this" {
  count = length(var.rg_env) > 0 ? length(var.rg_env) : 0

  location = values(var.rg_env)[count.index].location
  name     = values(var.rg_env)[count.index].name
  tags = {
    enviroment = values(var.rg_env)[count.index].environment
  }

}