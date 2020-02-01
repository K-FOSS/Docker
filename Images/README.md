# Docker Imgaes

This is the automated builders, scripts, and infrastructure to automate my Docker images and use in my services.

## Builder Documentation

All of the images are built using `docker buildx bake -f docker-compose.build.yml` the services in the file are making use of [Extension Fields](https://docs.docker.com/compose/compose-file/#extension-fields) to make easy use of the "Builders" I have created, at it's core it's a reusable `Dockerfile` that uses [Build Args]() to allow usage of a single Dockerfile for multiple images to save on clutter.


### Simple Builders

The simple builder is just a base OS like Alpine and a single `RUN` to install the PKGS specififed in PKGS build arg.


simpleAlpine `docker-compose.build.yml` service
```


```
### Advanced Builders