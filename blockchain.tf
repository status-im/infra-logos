module "blockchain" {
  source = "github.com/status-im/infra-tf-multi-provider"

  /* node type */
  name   = "blockchain"
  group  = "blockchain"
  env    = "logos"
  stage  = terraform.workspace

  /* scaling */
  ac_count = local.ws["ac_blockchain_count"]
  do_count = local.ws["do_blockchain_count"]
  gc_count = local.ws["gc_blockchain_count"]

  /* instance sizes */
  do_type = local.ws["blockchain_do_type"]
  ac_type = local.ws["blockchain_ac_type"]
  gc_type = local.ws["blockchain_gc_type"]

  /* data volumes */
  ac_data_vol_size = local.ws["blockchain_data_vol_size"]
  do_data_vol_size = local.ws["blockchain_data_vol_size"]
  gc_data_vol_size = local.ws["blockchain_data_vol_size"]

  /* firewall */
  open_tcp_ports = [
    "8080", /* blockchain REST API */
  ]
  open_udp_ports = [
    "3000", /* blockchain swarm (QUIC) */
    "3400", /* blockchain blend */
  ]
}