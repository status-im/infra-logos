# Description

This repo defines infrastructure for running [Logos](https://logos.co/) node fleet.

# Dashboard

You can look up current state of the fleet at: TODO

You can check fleet status via Canary service:

- TODO

# Layout

* `delivery` - The Logos delivery nodes running Waku V2 protocol.
* `delivery-db` - PostgreSQL used by `delivery` nodes for envelope storage.

# Discovery

DNS `TXT` ENRTree records exist to discover available fleets:
```
enrtree://<PUBLIC_KEY>@dev.logos.nodes.status.im
```

# Repo Usage

For how to use this repo read the [Infra Repo Usage](https://github.com/status-im/infra-docs/blob/master/docs/general/infra_repo_usage.md) doc.