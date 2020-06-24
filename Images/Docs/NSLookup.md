# K-FOSS/Docker NSLookup Image

## Tags

| Tag                                             | Description                                   |
| ----------------------------------------------- | --------------------------------------------- |
| kristianfoss/programs-nslookup:nslookup-scratch | NSLookup CLI with a `FROM scratch` base image |
| kristianfoss/programs-nslookup:nslookup-alpine  | NSLookup CLI with a `FROM alpine` base image  |

## Usage

You can use this image as a drop in replacement for the `nslookup` cli. Checkout my [Docker Script Loader System](https://github.com/K-FOSS/Docker/blob/master/Scripts/bin/nslookup)

```
docker run -it --rm kristianfoss/programs-nslookup:nslookup-scratch --help
```
