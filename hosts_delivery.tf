module "delivery" {
  source = "github.com/status-im/infra-tf-multi-provider"

  /* node type */
  name   = "delivery"
  group  = "delivery"
  env    = "logos"
  stage  = terraform.workspace

  /* scaling */
  ac_count = local.ws["ac_delivery_count"]
  do_count = local.ws["do_delivery_count"]
  gc_count = local.ws["gc_delivery_count"]

  /* instance sizes */
  do_type = local.ws["delivery_do_type"]
  ac_type = local.ws["delivery_ac_type"]
  gc_type = local.ws["delivery_gc_type"]

  /* data volumes */
  ac_data_vol_size = local.ws["delivery_data_vol_size"]
  do_data_vol_size = local.ws["delivery_data_vol_size"]
  gc_data_vol_size = local.ws["delivery_data_vol_size"]

  /* firewall */
  open_tcp_ports = [
    "80",    /* certbot */
    "8000",  /* p2p websocket */
    "30303", /* libp2p main */
  ]
  open_udp_ports = [
    "9000",  /* discovery v5 */
  ]
}