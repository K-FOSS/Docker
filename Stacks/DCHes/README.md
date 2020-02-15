# K-FOSS/Docker VPS Stacks

The `VPSX` folder in this directory are not actually what I'm running at this moment. These are my WIP soon to be deployed setups that will be using single node docker swarms to be able to make use of Docker configs.

The somewhat sanitized current configs are under the [`TMP`](./TMP/) folder in this directory. Right now the `docker-compose.yml` files running on the VPSes are full of secrets and I'm trying to move to using the new [`configureENVs.sh`](./Scripts/configureENVs.sh) script and [Docker Configs](https://docs.docker.com/engine/swarm/configs/)
