# K-FOSS/Docker TEMPLATE Image

## Tags

| Tag                     | Description                                                 |
| ----------------------- | ----------------------------------------------------------- |
| TEMPLATE:stable-scratch | TEMPLATE latest GitHub Tag with a `FROM scratch` base image |

## Usage

You can use this image as a drop in replacement for the `TEMPLATE` cli. Checkout my [Docker Script Loader System](https://github.com/K-FOSS/Docker/blob/master/Scripts/bin/cloudflared)

```
docker run -it --rm kristianfoss/programs-cloudflared:stable-scratch --help
```
