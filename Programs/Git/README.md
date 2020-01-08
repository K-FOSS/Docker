# Programs/Git

This is a `FROM scratch` Docker image containing just what is necessary to run [Git](https://git-scm.com/) in the Command line.

## Obtaining

This image is current pushed to Docker Hub, I will soon setup automated builds for everything here to Docker Hub and GitHub Package Registry

Replace IMAGE within this file with your preferred registry image.

DockerHub: `kristianfoss/programs-git`

## Usage

You can use this whereever you would normally just run `git`. You could even set it up as a Alias in your shell

```
docker run -it --rm -w /workdir -v $PWD:/workdir IMAGE clone https://github.com/K-FOSS/Docker-Images.git
```

Shell Alias

```
alias git='docker run -it --rm -w /workdir -v $PWD:/workdir IMAGE'
```

Since we are only mounting your current $PWD into the container you can only work within paths underneath your current $PWD
