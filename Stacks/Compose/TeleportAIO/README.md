# K-FOSS/Docker TeleportAIO Compose Template

[Website](https://gravitational.com/teleport/)

## Usage

Configure [Teleport.yaml](./Teleport.yml)

Bring up the compose stack

```
docker-compose up -d
```

Add a initial user

```
./bin/tctl user add USERNAME
```

This will output a url in your terminal open the URL and configure your user.
