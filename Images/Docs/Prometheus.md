# K-FOSS/Docker Prometheus Image

[Website](https://prometheus.io/)

[Repo/GitHub](https://github.com/prometheus/prometheus)

[Docs](https://prometheus.io/docs/prometheus/latest/getting_started/)

## Usage

### Tags

| Tag                                                        | Description                                                              |
| ---------------------------------------------------------- | ------------------------------------------------------------------------ |
| kristianfoss/programs-prometheus:prometheus-main-scratch   | Prometheus Main/Master Build CLI/Server with a `FROM scratch` base image |
| kristianfoss/programs-prometheus:prometheus-stable-scratch | Prometheus latest tag Build CLI/Server with a `FROM scratch` base image  |

## Usage

## Docker Run

```
docker run -it --rm -p 9090:9090 kristianfoss/programs-prometheus:prometheus-main-scratch
```

# Docker Compose

Checkout my Prometheus [Docker Compose Stack Example](https://github.com/K-FOSS/Docker/tree/feat-redesign/Stacks/Compose/Prometheus)
