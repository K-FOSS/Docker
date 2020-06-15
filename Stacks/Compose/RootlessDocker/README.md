# K-FOSS/Docker Rootless Docker in Docker Compose Template


## Usage

Run the prepare script that chowns the volume

```
./bin/prepare.sh
```

Bring up the docker-compose stack

```
docker-compose up -d
```

Run docker commands

```
docker-compose exec Docker images
docker-compose exec Docker run -it --rm hello-world
docker-compose exec Docker images
```