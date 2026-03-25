# Description

This repo defines infrastructure for running [Logos](https://logos.co/) node fleet.

# Dashboard

You can look up current state of the fleet at: TODO

You can check fleet status via Canary service:

- TODO

# Layout

The fleet uses two Terraform workspaces with different layouts:

## `logos.dev` - Development Fleet

Separate hosts per module for independent development and debugging.
Each team can break and test their component without affecting others.

* `delivery` - Delivery nodes running `waku_module` (relay, store, filter, lightpush, mix).
* `delivery-db` - PostgreSQL used by `delivery` nodes for message storage.
* `storage` - Storage nodes running `storage_module` (content-addressed storage).
* `blockchain` - Blockchain nodes running `liblogos_blockchain_module` (cryptarchia consensus).

## `logos.test` - Public Testnet

Combined nodes running all three modules on a single host.
Used by external users.

* `node` - Combined nodes running `waku_module`, `storage_module`, and `liblogos_blockchain_module`.
* `node-db` - PostgreSQL used by `node` instances for message storage.

# Discovery

DNS `TXT` ENRTree records exist to discover available fleets:
```
enrtree://<PUBLIC_KEY>@dev.logos.nodes.status.im
enrtree://<PUBLIC_KEY>@test.logos.nodes.status.im
```

# Repo Usage

For how to use this repo read the [Infra Repo Usage](https://github.com/status-im/infra-docs/blob/master/docs/general/infra_repo_usage.md) doc.