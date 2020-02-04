# K-FOSS/Servers Server Setup

With my recent exploration into scripting, docker based services, and Docker Swarm, I discovered I could move `SSHD` and `OpenVMTools` to running in Docker containers.

This is the setup scripts, and docker based services I plan to have on all my Servers/VMs.

# Server Setup

I have an automated setup/installer script to make install on servers easier since I have moved `SSHD` to a docker container I can't copy and paste my Docker and other app install snippets. So I decided to write a script to `wget` to provide easy setup to newly created servers without having to type a shitload of commands.

```
wget -O - https://raw.githubusercontent.com/K-FOSS/Docker/master/Stacks/Servers/setup.sh | bash
```
