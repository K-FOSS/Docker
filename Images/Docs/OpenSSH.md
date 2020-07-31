# K-FOSS/Docker OpenSSH Image

## Tags

| Tag                                                          | Description                                                                       |
| ------------------------------------------------------------ | --------------------------------------------------------------------------------- |
| kristianfoss/programs-openssh:ssh-cli-main-scratch           | OpenSSH main/master branch SSH CLI build with a `FROM scratch` base image         |
| kristianfoss/programs-openssh:ssh-cli-stable-scratch         | OpenSSH stable branch SSH CLI build with a `FROM scratch` base image              |
| kristianfoss/programs-openssh:sshd-cli-main-scratch          | OpenSSH main/master branch SSHD CLI build with a `FROM scratch` base image        |
| kristianfoss/programs-openssh:sshd-cli-stable-scratch        | OpenSSH stable branch SSHD CLI build with a `FROM scratch` base image             |
| kristianfoss/programs-openssh:ssh-keygen-cli-main-scratch    | OpenSSH main/master branch SSH-Keygen CLI build with a `FROM scratch` base image  |
| kristianfoss/programs-openssh:ssh-keygen-cli-stable-scratch  | OpenSSH stable branch SSH-Keygen CLI build with a `FROM scratch` base image       |
| kristianfoss/programs-openssh:ssh-add-cli-main-scratch       | OpenSSH main/master branch SSH-Add CLI build with a `FROM scratch` base image     |
| kristianfoss/programs-openssh:ssh-add-cli-stable-scratch     | OpenSSH stable branch SSH-Add CLI build with a `FROM scratch` base image          |
| kristianfoss/programs-openssh:ssh-agent-cli-main-scratch     | OpenSSH main/master branch SSH-Agent CLI build with a `FROM scratch` base image   |
| kristianfoss/programs-openssh:ssh-agent-cli-stable-scratch   | OpenSSH stable branch SSH-Agent CLI build with a `FROM scratch` base image        |
| kristianfoss/programs-openssh:ssh-keyscan-cli-main-scratch   | OpenSSH main/master branch SSH-Keyscan CLI build with a `FROM scratch` base image |
| kristianfoss/programs-openssh:ssh-keyscan-cli-stable-scratch | OpenSSH stable branch SSH-Keyscan CLI build with a `FROM scratch` base image      |
| kristianfoss/programs-openssh:ssh-keysign-cli-main-scratch   | OpenSSH main/master branch SSH-Keysign CLI build with a `FROM scratch` base image |
| kristianfoss/programs-openssh:ssh-keysign-cli-stable-scratch | OpenSSH stable branch SSH-Keysign CLI build with a `FROM scratch` base image      |

## Usage

### SSH

You can use this image as a drop in replacement for the `ssh` cli. Checkout my [Docker Script Loader System](https://github.com/K-FOSS/Docker/blob/master/Scripts/bin/cloudflared)

```
docker run -it --rm kristianfoss/programs-openssh:ssh-cli-main-scratch root@172.20.0.202
```

### SSHD

TODO

### SSH-Keygen

### SSH-ADD

TODO

### SSH-Agent

TODO

### SSH-Keyscan

You can use this image as a drop in replacement for the `ssh-keyscan` cli.

```
docker run -it --rm kristianfoss/programs-openssh:ssh-keyscan-cli-main-scratch 172.20.0.202
```

### SSH-Keyscan

TODO
