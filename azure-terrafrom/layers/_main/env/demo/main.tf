# _main

module "tfstate" {
  source = "../../modules/tfstate"
  Env    = var.Env
  region = var.region
  tags = {
    environment = "${var.Env}"
  }
}
