variable "rg_env" {
  type = map
  default = {
    rg_name = {
      location    = "Japan East"
      name        = "JpEast"
      environment = "dev"
    }
  }
}
