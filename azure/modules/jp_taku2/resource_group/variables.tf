variable "rg_env" {
  type = map(any)
  default = {
    rg_name = {
      location    = "Japan East"
      name        = "JpEast"
      environment = "dev"
    }
  }
}
