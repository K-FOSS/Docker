# Mono Scratch Image

This is a scratch image containing the bare minium to run programs with [Mono](https://www.mono-project.com/)

I don't personally use Mono but I needed this for Sonarr

## Registry Images

DockerHub: `kristianfoss/programs-mono`

## Usage

This should hopefully be able to be used as drop in replacement anywhere you would use `mono` if it doesn't work please create an issue here and let me know. I know it works for Sonarr.

Just replace `mono` with this:

```
docker run -it --rm REGISTRY_IMAGE
```
