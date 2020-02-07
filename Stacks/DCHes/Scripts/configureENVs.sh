#!/usr/bin/env bash
ENV_PATH="./ENVs/*.example.env"
FORCE=0

if [[ "$1" == "--force" ]] || [[ "$1" == "-f" ]]; then
  FORCE=1
fi

log() {
  echo "$@" >&1
}

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

traperr() {
  err "ERROR: ${BASH_SOURCE[1]}"
}

set -o errtrace
trap traperr ERR

confirm() {
  [[ "${FORCE}" -eq 1 ]] && log "Force mode enabled. Not prompting" && return 0

  local confirmPrompt=${@:-"Are you sure you want to do that? (y/n) "}

  read -p "${confirmPrompt} " -n 1
  log ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    return 0
  fi

  return 1
}

writeENVFile() {
  local envFilePath="$1"
  shift
  local envFile=("$@")

  if [[ -f "${OUT_PATH}" ]]; then
    confirm "Would you really like to overwrite existing '${OUT_PATH}'?" || return
  else
    log "${FILE} does not exist. We good to write"
  fi

  printf "%s\n" "${envFile[@]}" >"${OUT_PATH}"
}

main() {
  log "DCH Environment Variable configuration script starting"

  for envExamplePath in ${ENV_PATH}; do
    EXAMPLE_FILENAME=$(basename ${envExamplePath})

    ENV_NAME="${EXAMPLE_FILENAME%%.example*}"
    OUT_PATH="./ENVs/${ENV_NAME}.env"

    EXAMPLE_FILE="$(grep -v '^#' ${envExamplePath} | sed -E 's/(.*)=.*/\1/' | xargs)"

    log "Configuring variables for the ${ENV_NAME} with the example file of ${EXAMPLE_FILENAME}"

    IFS="=" read -ra ENV_VARS <<<"${EXAMPLE_FILE}"

    OUT_FILE=()

    for envVar in ${ENV_VARS[@]}; do
      ENV_EXAMPLE_LINE=$(grep -n "${envVar}=" ${envExamplePath} | cut -f1 -d:)
      log "ENV ${envVar} is found at ${ENV_EXAMPLE_LINE}"

      read -p "${ENV_NAME}[${envVar}]: " envValue

      VALUE="${envVar}=${envValue}"
      OUT_FILE+=($VALUE)
    done

    wait

    writeENVFile "${OUT_PATH}" "${OUT_FILE[@]}"
  done
}

main "$@"
