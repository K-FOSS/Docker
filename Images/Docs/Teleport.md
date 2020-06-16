# K-FOSS/Docker Teleport Image

[Website](https://gravitational.com/teleport/)

## Telelport

[Docs/Reference](https://gravitational.com/teleport/docs/cli-docs/#teleport)

### Tags

| Tag                                            | Description                                                              |
| ---------------------------------------------- | ------------------------------------------------------------------------ |
| kristianfoss/programs-teleport:alpine-teleport | Gravitional Teleport Teleport CLI/Server with a `FROM alpine` base image |

## Usage

See example [Compose Stack](https://github.com/K-FOSS/Docker/tree/master/Stacks/Compose/TeleportAIO)

## TCTL

[Docs/Reference](https://gravitational.com/teleport/docs/cli-docs/#tctl)

### Tags

| Tag                                        | Description                                                   |
| ------------------------------------------ | ------------------------------------------------------------- |
| kristianfoss/programs-teleport:alpine-tctl | Gravitional Teleport TCTL CLI with a `FROM alpine` base image |

### Usage

Used the same at the [TCTL](https://gravitational.com/teleport/docs/cli-docs/#tctl) cli but as a disposable container

Checkout my [Runner Script System](https://github.com/K-FOSS/Docker/blob/master/Scripts/bin/tctl)

```
docker run -it --rm kristianfoss/programs-teleport:alpine-tctl users add joe joe,root
```

## TSH

[Docs/Reference](https://gravitational.com/teleport/docs/cli-docs/#tsh)

### Tags

| Tag                                       | Description                                                   |
| ----------------------------------------- | ------------------------------------------------------------- |
| kristianfoss/programs-teleport:alpine-tsh | Gravitional Teleport TCTL CLI with a `FROM alpine` base image |

### Usage

Used the same at the [TSH](https://gravitational.com/teleport/docs/cli-docs/#tsh) cli but as a disposable container

Checkout my [Runner Script System](https://github.com/K-FOSS/Docker/blob/master/Scripts/bin/tsh)

```
docker run -it --rm kristianfoss/programs-teleport:alpine-tsh --proxy=proxy.example.com:8080 login
```
