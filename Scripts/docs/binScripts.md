# `/usr/bin` scripts

## Template

```sh
CLI_IMAGE="CLI_IMAGE"

CLI_NAME="CLI_NAME-cli"

ensure-docker-cli "${CLI_NAME}" "${CLI_IMAGE}" "-v ${HOME}:/tmp/home${HOME}  -e HOME=/tmp/home${HOME}"

exec docker exec -it --workdir "/tmp/home${PWD}" ${CLI_NAME} /usr/bin/CLI_NAME "${@}"
```
