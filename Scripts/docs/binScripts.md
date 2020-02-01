# `/usr/bin` scripts

## Template

```sh
CLI_IMAGE="kristianfoss/programs-keybase:alpine-client"

CLI_NAME="keybase-client-cli"

/usr/local/bin/ensure-docker-cli "${CLI_NAME}" "${CLI_IMAGE}" "-v ${HOME}:${HOME} -e HOME=${HOME}"

exec /usr/local/bin/docker exec -t --workdir "${PWD}" ${CLI_NAME} /usr/bin/keybase "${@}"
```