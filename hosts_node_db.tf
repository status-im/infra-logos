module "node-db" {
  source = "github.com/status-im/infra-tf-multi-provider"

  name   = "node-db"
  group  = "node-db"
  env    = "logos"
  stage  = terraform.workspace

  ac_count = local.ws["ac_node_db_count"]
  do_count = local.ws["do_node_db_count"]
  gc_count = local.ws["gc_node_db_count"]

  do_type = local.ws["node_db_do_type"]
  ac_type = local.ws["node_db_ac_type"]
  gc_type = local.ws["node_db_gc_type"]

  ac_data_vol_size = local.ws["node_db_data_vol_size"]
  do_data_vol_size = local.ws["node_db_data_vol_size"]
  gc_data_vol_size = local.ws["node_db_data_vol_size"]
}
