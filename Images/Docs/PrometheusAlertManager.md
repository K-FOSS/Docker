# K-FOSS/Docker Prometheus Alert Manager Image

[AlertManager Website/GitHub](https://github.com/prometheus/alertmanager)

[AlertManager Docs](https://prometheus.io/docs/alerting/latest/alertmanager/)

## Tags

| Tag                                                                                  | Description                                                                             |
| ------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------- |
| kristianfoss/programs-prometheus-alertmanager:prometheus-alertmanager-main-scratch   | Prometheus AlertManager main/master branch built with a `FROM scratch` final base image |
| kristianfoss/programs-prometheus-alertmanager:prometheus-alertmanager-stable-scratch | Prometheus AlertManager latest GitHub Tag with a `FROM scratch` base image              |

## Usage

You can use this image as a drop in replacement for the `alertmanager` cli.

```
docker run -it --rm kristianfoss/programs-prometheus-alertmanager:prometheus-alertmanager-main-scratch --help
```
