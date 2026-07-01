#!/usr/bin/env python3
"""Collect storage network info for group vars. Output is copy-paste YAML."""
import subprocess, json, sys, re

inventory = sys.argv[1] if len(sys.argv) > 1 else 'ansible/inventory'
group = sys.argv[2] if len(sys.argv) > 2 else 'storage'

out = subprocess.run(
    ['ansible', '-i', inventory, group, '-m', 'shell', '-a',
     'docker exec logos-node logoscore --config-dir /var/lib/logos/config call storage_module debug',
     '-b'],
    capture_output=True, text=True
).stdout

nodes = {}
host = None
for line in out.splitlines():
    m = re.match(r'^(\S+)\s+\|\s+CHANGED', line)
    if m:
        host = m.group(1)
        continue
    if host and line.strip().startswith('{'):
        try:
            nodes[host] = json.loads(line)['result']['value']
        except (json.JSONDecodeError, KeyError):
            pass
        host = None

if not nodes:
    print('No nodes responded.', file=sys.stderr)
    sys.exit(1)

first = next(iter(nodes))
print("logos_node_storage_bootstrap_nodes:")
print("  - '%s'" % nodes[first]['spr'])
print()
print("logos_node_storage_dht_mix_proxy:")
for h, d in nodes.items():
    print("  - '%s'  # %s" % (d['providerRecord'], h))
print()
print("logos_node_storage_mix_pool_relays:")
for h, d in nodes.items():
    print("  - peerId: '%s'" % d['id'])
    print("    multiAddr: '%s'" % d['announceAddresses'][0])
    print("    mixPubKey: '%s'" % d['mixPubKey'])
    print("    libp2pPubKey: '%s'" % d['libp2pPubKey'])