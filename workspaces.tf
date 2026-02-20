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

      /* Number of delivery hosts per data center */
      ac_delivery_count = 1
      do_delivery_count = 1
      gc_delivery_count = 1

      /* Delivery host sizes */
      delivery_do_type = "s-1vcpu-2gb"        /* DigitalOcean */
      delivery_ac_type = "ecs.t5-lc1m2.small" /* Alibaba Cloud */
      delivery_gc_type = "g1-small"           /* Google Cloud */

      /* Number of DB hosts per data center */
      ac_db_count = 1
      do_db_count = 1
      gc_db_count = 1

      /* DB host sizes */
      db_do_type = "s-1vcpu-2gb"        /* DigitalOcean */
      db_ac_type = "ecs.t5-lc1m2.small" /* Alibaba Cloud */
      db_gc_type = "g1-small"           /* Google Cloud */

      /* Data volumes */
      delivery_data_vol_size = 40
      db_data_vol_size       = 100
    }

    /* Settings specific to the fleet/workspace. */
    dev = {
      delivery_do_type = "s-2vcpu-4gb"
      delivery_ac_type = "ecs.t5-lc1m2.large"
      delivery_gc_type = "c2d-highcpu-2"

      db_do_type = "s-2vcpu-4gb"
      db_ac_type = "ecs.t5-lc1m2.large"
      db_gc_type = "c2d-highcpu-2"

      db_data_vol_size = 320
    }
  }
}

/* Makes fleet settings available under local.ws. */
locals {
  ws = merge(local.env["defaults"], local.env[terraform.workspace])
}