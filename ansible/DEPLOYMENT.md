# Deployment

## Delivery

Two-phase deploy. Bootstrap list needs peer IDs from running nodes.

1. Deploy all nodes
2. Collect peer IDs from delivery debug API, populate `logos_node_delivery_kad_bootstrap_nodes` in group vars with `/dns4/<hostname>/tcp/30303/p2p/<peerID>` entries
3. Redeploy

## Storage v0.2

Two-phase deploy. Two node types: Mix-Proxy (MP, minimum 4) and Regular Storage (RS). RS nodes need mix-pool and proxy config from running MP nodes.

- Storage keys in Vault must have libp2p protobuf header `08021220` prepended to the raw 32-byte hex key

1. Deploy all nodes - RS nodes start without mix routing (template skips mix-pool when `dht_mix_proxy` is empty)
2. Run `ansible/files/storage-info.py` to collect MP node info, copy output into group vars, remove RS node entries from `dht_mix_proxy` and `mix_pool_relays`
3. Redeploy - RS nodes get mix-pool.json and dht-mix-proxy, content preload runs automatically on RS nodes

## Blockchain

Currently disabled due to upstream bug.