/**
 * This is a hacky way of binding specific variable
 * values to different Terraform workspaces.
 *
 * Details:
 * https://github.com/hashicorp/terraform/issues/15966
 */

locals {
  env = {
    defaults = {
      /* Default settings for all fleets/workspaces. */

      ac_delivery_count = 0
      do_delivery_count = 0
      gc_delivery_count = 0

      delivery_do_type = "s-2vcpu-4gb"        /* DigitalOcean */
      delivery_ac_type = "ecs.t5-lc1m2.large" /* Alibaba Cloud */
      delivery_gc_type = "e2-medium"           /* Google Cloud */

      delivery_data_vol_size = 40

      ac_db_count = 0
      do_db_count = 0
      gc_db_count = 0

      db_do_type = "s-2vcpu-4gb"        /* DigitalOcean */
      db_ac_type = "ecs.t5-lc1m2.large" /* Alibaba Cloud */
      db_gc_type = "e2-medium"           /* Google Cloud */

      db_data_vol_size = 100

      ac_storage_count = 0
      do_storage_count = 0
      gc_storage_count = 0

      storage_do_type = "s-2vcpu-4gb"        /* DigitalOcean */
      storage_ac_type = "ecs.t5-lc1m2.large" /* Alibaba Cloud */
      storage_gc_type = "e2-medium"           /* Google Cloud */

      storage_data_vol_size = 40

      ac_blockchain_count = 0
      do_blockchain_count = 0
      gc_blockchain_count = 0

      blockchain_do_type = "s-2vcpu-4gb"        /* DigitalOcean */
      blockchain_ac_type = "ecs.t5-lc1m2.large" /* Alibaba Cloud */
      blockchain_gc_type = "e2-medium"           /* Google Cloud */

      blockchain_data_vol_size = 40

      /* Logos Chat KeyPackage cache. */
      ac_chat_kc_count = 0
      do_chat_kc_count = 0
      gc_chat_kc_count = 0

      chat_kc_do_type = "s-1vcpu-2gb"        /* DigitalOcean */
      chat_kc_ac_type = "ecs.t5-lc1m2.large" /* Alibaba Cloud */
      chat_kc_gc_type = "e2-medium"          /* Google Cloud */

      chat_kc_data_vol_size = 30

      /* Combined nodes running multiple Logos modules. */
      ac_node_count = 0
      do_node_count = 0
      gc_node_count = 0

      node_do_type = "s-2vcpu-4gb"        /* DigitalOcean */
      node_ac_type = "ecs.t5-lc1m2.large" /* Alibaba Cloud */
      node_gc_type = "e2-medium"           /* Google Cloud */

      node_gc_root_vol_size = 15
      node_ac_root_vol_size = 20
      node_data_vol_size = 40

      ac_node_db_count = 0
      do_node_db_count = 0
      gc_node_db_count = 0

      node_db_do_type = "s-2vcpu-4gb"        /* DigitalOcean */
      node_db_ac_type = "ecs.t5-lc1m2.large" /* Alibaba Cloud */
      node_db_gc_type = "e2-medium"           /* Google Cloud */

      node_db_data_vol_size = 100

      lez_node_ips = []
    }

    dev = {
      ac_delivery_count = 2
      do_delivery_count = 2
      gc_delivery_count = 2

      delivery_do_type = "s-2vcpu-4gb"
      delivery_ac_type = "ecs.t5-lc1m2.large"
      delivery_gc_type = "c2d-highcpu-2"

      ac_db_count = 1
      do_db_count = 1
      gc_db_count = 1

      db_do_type = "s-2vcpu-4gb"
      db_ac_type = "ecs.t5-lc1m2.large"
      db_gc_type = "c2d-highcpu-2"

      db_data_vol_size = 320

      ac_storage_count = 2
      do_storage_count = 2
      gc_storage_count = 2

      ac_blockchain_count = 1
      do_blockchain_count = 1
      gc_blockchain_count = 1

      do_chat_kc_count = 1

      lez_node_ips = []
    }
    test = {
      ac_node_count = 2
      do_node_count = 2
      gc_node_count = 2

      node_do_type = "s-4vcpu-8gb"
      node_ac_type = "ecs.t5-lc1m4.large"
      node_gc_type = "c2d-standard-4"

      node_gc_root_vol_size = 40
      node_ac_root_vol_size = 40
      node_data_vol_size = 80

      ac_node_db_count = 1
      do_node_db_count = 1
      gc_node_db_count = 1

      node_db_do_type = "s-2vcpu-4gb"
      node_db_ac_type = "ecs.t5-lc1m2.large"
      node_db_gc_type = "c2d-highcpu-2"

      node_db_data_vol_size = 320

      lez_node_ips = [
        "65.108.237.32", # lez-01.he-eu-hel1.logos.test
      ]
    }
  }
}

/* Makes fleet settings available under local.ws. */
locals {
  ws = merge(local.env["defaults"], local.env[terraform.workspace])
}
