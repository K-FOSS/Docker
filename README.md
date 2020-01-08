# K-FOSS Docker Images

This is a collection of Docker images I have created because nothing that already existed fit my needs. I.E no `FROM scratch` final image with proper security and the bare minimum needed to run.

## Plans

I want to setup a system so that I can publish to multiple registrys and the images that have depends on other images that are built within the same repo use the registry base image from the same. If that makes sense. So if I publish to GitHub Registry + Docker Hub the Docker Hub Sonarr Image would be `FROM REPO/USER/Program/Mono` and the GitHub Registry would be `FROM docker.pkg.github.com/REPO/USER/Program/Mono` this should be able to be done either with build args or ENV replacement. Maybe if all images were in a root `docker-compose.yml` and then image repo is set with env and built with `docker-compose build`

## Images

### Programs

#### Programs/Git

GIT CLI `FROM scratch` base image.

#### Programs/NodeJS

NodeJS CLI `FROM scratch` base image.

#### Programs/Mono

Mono CLI `FROM scratch` base image.
