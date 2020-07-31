# K-FOSS/Docker CloudflareD Image

## Tags

| Tag                                              | Description                                                               |
| ------------------------------------------------ | ------------------------------------------------------------------------- |
| kristianfoss/programs-cloudflared:stable-scratch | Cloudflared CLI/Server latest GitHub Tag with a `FROM scratch` base image |
| kristianfoss/programs-cloudflared:main-scratch   | Cloudflared CLI/Server main branch with a `FROM scratch` base image       |

## Usage

You can use this image as a drop in replacement for the `cloudflared` cli. Checkout my [Docker Script Loader System](https://github.com/K-FOSS/Docker/blob/master/Scripts/bin/cloudflared)

```
docker run -it --rm kristianfoss/programs-cloudflared:stable-scratch --help
```
