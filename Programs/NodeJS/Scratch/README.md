# Programs/NodeJS:scratch

This is a `FROM scratch` Docker image with the latest NodeJS master nightly source download from [NodeJS Downloads](https://nodejs.org/download/nightly/)

The Dockerfile uses `wget` to fetch the downloads page and pipe to stdout which is then piped into `grep -o -E '(v14\.0\.0-nightly[A-Za-z0-9]+)' | tail -1` I will soon change it to not have 14.0.0 hardcoded. Since this is a slightly hacky way of obtaining the source download this could break at any time and I will soon try to find a solution

## Registry Image

DockerHub: `kristianfoss/programs-nodejs:scratch`

## Tags

## Usage

Pull this image from whatever your favorite registry is.

This should be able to be used just like the NodeCLI. Or used as a base image for your NodeJS applications

```
docker pull -it --rm kristianfoss/programs-nodejs:scratch
```
