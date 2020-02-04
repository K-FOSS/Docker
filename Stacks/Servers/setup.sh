#!/usr/bin/env bash
REQUIRED_PKGS="gnupg-agent software-properties-common socat"

# check os
OSTYPE=unknown
UNAME=$(uname -a)
[[ $UNAME =~ "Darwin" ]] && OSTYPE=macos
[[ $UNAME =~ "Ubuntu" ]] && OSTYPE=ubuntu

installPackage() {
  local packages="${1}"

  # TODO: Add support for more distributions
  if [ "${OSTYPE}" == "ubuntu" ]; then
    apt-get install -y "${packages}"
  else
    echo "Installing not supported on this distribution... Yet!"
  fi
}

addRepo() {
  local repoKeyURL="${1}"
  local repoURL="${2}"

  # TODO: Add support for more distributions
  if [ "${OSTYPE}" == "ubuntu" ]; then
    wget -O - ${keyURL} | apt-key add -
    add-apt-repository "deb [arch=amd64] ${repoURL} $(lsb_release -cs) stable"
  else
    echo "Installing not supported on this distribution... Yet!"
  fi
}

echo "Installing Packages"

installPackage "${REQUIRED_PKGS}"

echo "Adding Docker repo keys & repo"

## TODO: Move this to OS independant
addRepo "https://download.docker.com/linux/ubuntu/gpg" "https://download.docker.com/linux/ubuntu"

echo "Installing docker packages"

installPackage "docker-ce docker-ce-cli containerd.io"

echo "Packages installed. testing 'docker --help'."
docker --help

echo "Installing 'docker-compose'"

wget -O /usr/local/bin/docker-compose "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)"

echo "Making 'docker-compose.yml' executable"

chmod +x /usr/local/bin/docker-compose

echo "Installing Server Services Stack from the 'installServices.sh' script in the K-FOSS/Docker Stacks/Servers/installServices.sh"

wget -O - https://raw.githubusercontent.com/K-FOSS/Docker/master/Stacks/Servers/setup.sh | bash
