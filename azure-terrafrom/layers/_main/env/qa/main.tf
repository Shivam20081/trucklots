# _main

module "tfstate" {
  source = "../../modules/tfstate"
  Env    = var.Env
  region = var.region
  tags = {
    Env = "${var.Env}"
    EnvAcct = "nonp"
    AppSuite = "tfstate"
  }
}
