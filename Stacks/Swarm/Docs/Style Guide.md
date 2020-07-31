# K-FOSS/Docker Docker Swarm Stack Style Guide

This is a outline on how to structure/write Docker Stack Swarm Compsoe Files

## Order

```yml
serviceName:
  image: ImageName
  command?: ['COMMAND', ...ARGS]
  configs:
    - source: Caddyfile
      target: /etc/caddy/Caddyfile.json
  secrets:
    - source: OMSWSID
      target: WSID
    - source: OMSKey
      target: KEY
  deploy:
    replicas: 6
    restart_policy:
      condition: on-failure
      delay: 10s
      max_attempts: 5
      window: 120s
    rollback_config:
      parallelism: 1
      delay: 15s
      monitor: 15s
      max_failure_ratio: 1
      order: start-first
    update_config:
      parallelism: 2
      delay: 15s
      monitor: 15s
      order: start-first
  cap_add?:
    - CAP
  env_file?: ENVs/SERVICE.env
  environment:
    RANDOM_STR: RANDOM_VALUE
    RANDOM_BOOL: 'true/false'
    RANDOM_INT: 1/2/3
  volumes?:
    - VOLUMENAME:/MOUNTTYPE
  networks?:
    - NETWORK_NAME
  ports?:
    - target: 25565
      published: 25567
      protocol: tcp
      mode: ingress
    - target: 25565
      published: 25567
      protocol: udp
      mode: ingress
  labels?:
    LABEL: LABEL_VALUE
```

## Examples

### Caddy Reverse Proxy

```YAML
  Web:
    image: caddy/caddy:scratch
    restart: unless-stopped
    command: ['caddy', 'run', '--config', '/etc/Caddy/Caddyfile.json']
    volumes:
      - ./Caddyfile.json:/etc/Caddy/Caddyfile.json:ro
    networks:
      - publicWeb
    ports:
      - 80:8080
      - 443:8443/tcp
      - 443:8443/udp
```
