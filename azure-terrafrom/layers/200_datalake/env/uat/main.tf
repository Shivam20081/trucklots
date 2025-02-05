# 200_datalake

locals {
  tags = {
    environment = "${var.Env}"
  }
}

module "storage-account" {
  source = "../../modules/storage-account"
  Env    = var.Env
}