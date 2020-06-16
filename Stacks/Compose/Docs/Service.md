# K-FOSS/Docker Docker Compose Stacks Service Docs

This document outlines how to create Docker Compose Service

## Order

```yml
serviceName:
  image: ImageName
  restart: RestartType
  command?: ['COMMAND', ...ARGS]
  privileged?: true/false
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
    - OUTSIDE_PORT:INSIDE_PORT
  depends_on:
    - OTHER
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
