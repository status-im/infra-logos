module "chat-kc" {
  source = "github.com/status-im/infra-tf-multi-provider"

  /* node type */
  name  = "chat-kc"
  group = "chat-kc"
  env   = "logos"
  stage = terraform.workspace

  /* scaling */
  ac_count = local.ws["ac_chat_kc_count"]
  do_count = local.ws["do_chat_kc_count"]
  gc_count = local.ws["gc_chat_kc_count"]

  /* instance sizes */
  do_type = local.ws["chat_kc_do_type"]
  ac_type = local.ws["chat_kc_ac_type"]
  gc_type = local.ws["chat_kc_gc_type"]

  /* data volumes */
  ac_data_vol_size = local.ws["chat_kc_data_vol_size"]
  do_data_vol_size = local.ws["chat_kc_data_vol_size"]
  gc_data_vol_size = local.ws["chat_kc_data_vol_size"]

  /* firewall */
  open_tcp_ports = [
    "80",  /* certbot */
    "443", /* public https */
  ]
}

resource "cloudflare_record" "devnet_chat_kc" {
  zone_id = lookup(local.zones, "logos.co")
  name    = "devnet.chat-kc"
  value   = module.chat-kc.public_ips[0]
  type    = "A"
  proxied = false
}