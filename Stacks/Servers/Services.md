# K-FOSS/Docker VMs Docker Services

As part of my dockerize everything project I have managed to get the [`open-vm-tools`]() and the `OpenSSH SSHD` services running in a docker container instead of installed on the VM/Servers themselves. This is the general configuration for that.

## Usage

To provide easy installation, since `open-vm-tools` and `sshd` are part of this stack I have created a [installer script](./install.sh) to download the [sshd.service](./systemd/sshd.service) and [docker-compose.yml](./docker-compose.yml) to `/etc/systemd/system/sshd.service` and `~/Docker-Services` by default, they can be overriden with the environment variables of `SERVICE_PATH` and `PROJECT_PATH` Please be careful when running scripts from the internet, and especially this one since it is geared to my workflow specificly and can/will break with your setups.

### WARNING

This script is currently only designed to be run on Ubuntu 19.04 or Ubuntu 19.10

```
wget -O - https://raw.githubusercontent.com/K-FOSS/Docker/master/Stacks/Servers/installServices.sh | bash
```
