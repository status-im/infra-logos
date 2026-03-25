module "storage" {
  source = "github.com/status-im/infra-tf-multi-provider"

  /* node type */
  name   = "storage"
  group  = "storage"
  env    = "logos"
  stage  = terraform.workspace

  /* scaling */
  ac_count = local.ws["ac_storage_count"]
  do_count = local.ws["do_storage_count"]
  gc_count = local.ws["gc_storage_count"]

  /* instance sizes */
  do_type = local.ws["storage_do_type"]
  ac_type = local.ws["storage_ac_type"]
  gc_type = local.ws["storage_gc_type"]

  /* data volumes */
  ac_data_vol_size = local.ws["storage_data_vol_size"]
  do_data_vol_size = local.ws["storage_data_vol_size"]
  gc_data_vol_size = local.ws["storage_data_vol_size"]

  /* firewall */
  open_tcp_ports = [
    "80",   /* certbot */
    "8080", /* storage libp2p */
  ]
  open_udp_ports = [
    "9090", /* storage discovery */
  ]
}