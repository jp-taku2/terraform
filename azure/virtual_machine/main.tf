provider "azurerm" {
  version = "=2.35.0"
  features {
  }
}

module "resource_group" {
  source = "../modules/jp_taku2/resource_group"

  rg_env = {
    "1-Dev-JpEast" = {
      location = "Japan East"
      name = "Dev-JpEast"
      environment = "dev"
    },
    "2-Prod-JpEast" = {
      location = "Japan East"
      name = "Prod-JpEast"
      environment = "prod"
    }
  }
}


