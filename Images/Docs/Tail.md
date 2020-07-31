# K-FOSS/Docker Tail Image

## Tags

| Tag                                            | Description                               |
| ---------------------------------------------- | ----------------------------------------- |
| kristianfoss/programs-tail:tail-stable-scratch | Tail CLI with a `FROM scratch` base image |
| kristianfoss/programs-tail:tail-stable-alpine  | Tail CLI with a `FROM alpine` base image  |

## Usage

You can use this image as a drop in replacement for the `tail` cli. Checkout my [Docker Script Loader System](https://github.com/K-FOSS/Docker/blob/master/Scripts/bin/tail)

```
echo "HELLO WORLD\nHELLO WORLD Line2\nHello World Line3\nHello World Line4" | docker run -i --rm kristianfoss/programs-tail:tail-stable-scratch -n 2
```
