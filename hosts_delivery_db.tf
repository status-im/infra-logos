module "delivery-db" {
  source = "github.com/status-im/infra-tf-multi-provider"

  /* node type */
  name   = "delivery-db"
  group  = "delivery-db"
  env    = "logos"
  stage  = terraform.workspace

  /* scaling */
  ac_count = local.ws["ac_db_count"]
  do_count = local.ws["do_db_count"]
  gc_count = local.ws["gc_db_count"]

  /* instance sizes */
  do_type = local.ws["do_db_type"]
  ac_type = local.ws["ac_db_type"]
  gc_type = local.ws["gc_db_type"]

  /* data volumes */
  ac_data_vol_size = local.ws["db_data_vol_size"]
  do_data_vol_size = local.ws["db_data_vol_size"]
  gc_data_vol_size = local.ws["db_data_vol_size"]
}