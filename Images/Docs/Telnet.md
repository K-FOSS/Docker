# K-FOSS/Docker Telnet Image

## Tags

| Tag                                         | Description                                 |
| ------------------------------------------- | ------------------------------------------- |
| kristianfoss/programs-telnet:telnet-scratch | Telnet CLI with a `FROM scratch` base image |
| kristianfoss/programs-telnet:telnet-alpine  | Telnet CLI with a `FROM alpine` base image  |

## Usage

You can use this image as a drop in replacement for the `telnet` cli. Checkout my [Docker Script Loader System](https://github.com/K-FOSS/Docker/blob/master/Scripts/bin/telnet)

```
docker run -it --rm kristianfoss/programs-telnet:telnet-scratch --help
```
