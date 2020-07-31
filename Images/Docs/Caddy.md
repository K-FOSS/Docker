# K-FOSS/Docker Caddy Image

[Caddy Website](https://caddyserver.com/)

[Caddy GitHub](https://github.com/caddyserver/caddy)

[Caddy Docs](https://caddyserver.com/docs/)

[Image Repo](https://github.com/K-FOSS/Docker)

## Tags

| Tag                                                       | Description                                                     | Plugins                                                                                                                                                                                                                                                    |
| --------------------------------------------------------- | --------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| kristianfoss/programs-caddy:caddy-main-scratch            | Caddy main/master branch built with a `FROM scratch` base image |                                                                                                                                                                                                                                                            |
| kristianfoss/programs-caddy:caddy-prometheus-main-scratch | Caddy main/master branch built with a `FROM scratch` base image | [CloudflareDNS](https://github.com/caddy-dns/cloudflare), [CaddyPrometheusExporter](https://github.com/hairyhenderson/caddyprom)                                                                                                                           |
| kristianfoss/programs-caddy:caddy-auth-main-scratch       | Caddy main/master branch built with a `FROM scratch` base image | [CloudflareDNS](https://github.com/caddy-dns/cloudflare), [CaddyPrometheusExporter](https://github.com/hairyhenderson/caddyprom), [CaddyAuthSAML](https://github.com/greenpau/caddy-auth-saml), [CaddyAuthJWT](https://github.com/greenpau/caddy-auth-jwt) |

## Usage

You can use this image as a drop in replacement for the `caddy` cli.

```
docker run -it --rm kristianfoss/programs-caddy:caddy-main-scratch --help
```

## Docker Compose

Check out my [Example Compose Stack Template](https://github.com/K-FOSS/Docker/tree/master/Stacks/Compose/Caddy)
