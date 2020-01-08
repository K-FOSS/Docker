# Applications/Media-Server/Sonarr

This is a Docker image for the [Sonarr](https://sonarr.tv/) application

## Registry Image

Dockerhub: `kristianfoss/applications-mediaserver-sonarr:latest`

## Usage

```
docker volume create sonarrConfig

docker run -it -v sonarrConfig:/config -p 8989:8989 kristianfoss/applications-mediaserver-sonarr:latest
```
