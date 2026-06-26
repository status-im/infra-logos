/* DATA -----------------------------------------*/

terraform {
  backend "consul" {
    address = "https://consul.statusim.net:8400"
    /* Lock to avoid syncing issues */
    lock = true
    /* KV store has a limit of 512KB */
    gzip = true
    /* WARNING This needs to be changed for every repo. */
    path      = "terraform/logos/"
  }
}

/* CF Zones ------------------------------------*/

/* CloudFlare Zone IDs required for records */
data "cloudflare_zones" "active" {
  filter { status = "active" }
}

/* For easier access to zone ID by domain name */
locals {
  zones = {
    for zone in data.cloudflare_zones.active.zones :
    zone.name => zone.id
  }
}