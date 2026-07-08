module "node" {
  source = "github.com/status-im/infra-tf-multi-provider"

  name   = "node"
  group  = "node"
  env    = "logos"
  stage  = terraform.workspace

  ac_count = local.ws["ac_node_count"]
  do_count = local.ws["do_node_count"]
  gc_count = local.ws["gc_node_count"]

  do_type = local.ws["node_do_type"]
  ac_type = local.ws["node_ac_type"]
  gc_type = local.ws["node_gc_type"]

  gc_root_vol_size = local.ws["node_gc_root_vol_size"]
  ac_root_vol_size = local.ws["node_ac_root_vol_size"]

  ac_data_vol_size = local.ws["node_data_vol_size"]
  do_data_vol_size = local.ws["node_data_vol_size"]
  gc_data_vol_size = local.ws["node_data_vol_size"]

  open_tcp_ports = [
    "80",    /* certbot */
    "8000",  /* delivery WSS */
    "8008",  /* storage metrics */
    "8070",  /* storage libp2p */
    "8080",  /* blockchain REST API */
    "8091",  /* storage REST API */
    "30303", /* delivery libp2p */
  ]
  open_udp_ports = [
    "3000", /* blockchain swarm (QUIC) */
    "3400", /* blockchain blend */
    "9000", /* delivery discv5 */
    "9090", /* storage discovery */
  ]
}
