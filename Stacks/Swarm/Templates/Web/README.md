# Web Stack

![stability-wip](https://img.shields.io/badge/stability-work_in_progress-lightgrey.svg)


You must first already have a Docker swarm setup. (It does work with single node swarm)

Then just run the `./deployWeb.sh` to deploy and again when you want to update the `Caddy.json` file.

It uses a `.count` file in this folder to be able to push a new [Docker Config](https://docs.docker.com/engine/swarm/configs/) on every run of the script.