# OpenSSH Docker Image

[Repo](https://github.com/K-FOSS/Docker)
[Dockerfile](https://github.com/K-FOSS/Docker/blob/master/Images/OpenSSH/Dockerfile)

This is a Docker image for using [OpenSSH](https://www.openssh.com/)

## Usage

### SSH

This is a docker image/tag containing the OpenSSH SSH CLI.

This should be a drop in replacement anywhere you would use `ssh`

Here is an example of `ssh root@192.168.10.1` using the Image instead.

```
docker run -it --rm kristianfoss/programs-openssh:scratch-ssh root@192.168.10.1
```

### SSH-Keygen

This is a docker image/tag containing the OpenSSH ssh-keygen command.

This should be a drop in replacement anywhere you would use `ssh-keygen`

Here is an example of generating a sshkey `` using the image instead

```
docker run -it --rm -w /tmp/$PWD -v $PWD:/tmp$PWD kristianfoss/programs-openssh:scratch-ssh-keygen
```
