# Description

This role deploys [chat-store](https://github.com/logos-messaging/chat-store), an HTTP service that caches MLS KeyPackages for Logos Chat. Clients publish signed keypackages keyed by `device_id` (and device-list bundles keyed by `account_pub`) so contacts can be reached by ID without an out-of-band key exchange.

The service is intentionally throwaway: it will be replaced by a λLEZ-based service in Logos Chat v0.3. It runs as a single Docker container (axum + rusqlite) behind an nginx reverse proxy with TLS.

# Configuration

The basic include:
```yaml
chat_kc_public_domain: 'devnet.chat-kc.logos.co'
chat_kc_image_tag: 'deploy-logos-dev'
```

The container is built from the chat-store repo, pushed to Harbor, and pulled on the host. Retention and limits are passed as CLI flags to the binary:
```yaml
chat_kc_retention_days: 21       # drop bundles older than this
chat_kc_max_per_identity: 100    # bundles retained per device_id
chat_kc_prune_interval_secs: 3600
```

The SQLite database is stored on a persistent volume:
```yaml
chat_kc_data_dir: '/docker/chat-kc/data'   # mounted to /data in the container
```

# Ports

* `8080` - HTTP API, bound to `127.0.0.1` (nginx proxies to it)
* `443` - public HTTPS (nginx reverse proxy, Let's Encrypt cert)
* `80` - certbot HTTP-01 challenge

The container is never exposed directly; nginx terminates TLS for `chat_kc_public_domain` and proxies to the local container. A `limit_req` zone rate-limits requests per client IP.

# Management

The service runs via Docker Compose:
```
 $ docker ps | grep chat-kc
chat-kc   harbor.status.im/logos-messaging/chat-store:deploy-logos-dev   Up 2 hours

 $ docker logs chat-kc --tail 1
INFO chat_store: chat-store listening on 0.0.0.0:8080
```

Check the API (returns 404 for an unknown device, which means the service is live):
```
 $ curl -s https://devnet.chat-kc.logos.co/v0/keypackage/deadbeef
{"error":"no keypackage for device"}
```

The image is updated by Watchtower when a new tag is pushed to Harbor.

# API

* `POST /v0/keypackage` - publish a signed keypackage bundle for a `device_id`
* `GET /v0/keypackage/{device_id}` — fetch the latest bundle, or 404
* `POST /v0/account` - upsert the device-list bundle for an `account_pub`
* `GET /v0/account/{account_pub}` — fetch the stored bundle, or 404

The server verifies the Ed25519 signature over the payload before storing; it never decodes the payload itself. Consumers must re-verify on retrieve. See the [chat-store README](https://github.com/logos-messaging/chat-store) for the trust model.