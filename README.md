# Graylog observability

This repository showcases a redundant, highly available, multi-node Graylog 
cluster. Following this demo will teach you to create three service replicas per 
service across three nodes for the following: 

- HAProxy
- Graylog 
- Elasticsearch
- Mongodb

This will allow you to maintain quorum and create a highly available logging 
cluster that can be updated and maintained with zero downtime. Beyond that we 
will explore the best practices for configuration, security, TLS termination and
more.

## System requirements

### CPU

- Minimum: 2 cores
- Recommended: 4 cores

### RAM

- Minimum: 4 Gb
- Recommended: 8 Gb

## Quick start (manual)

For the purposes of this example we will assume you have three servers set up
with the following IP address's:

- Manager: 100.100.0.1
- Worker 1: 100.100.0.2
- Worker 2: 100.100.0.3

You should replace the IP address's above with your server's IP Address's. While
we use three in this demo, you can use a single server for testing purposes. 
However, you should always use three or more servers in production with an odd 
number of managers in order to [maintain quorum][1].

### Set up your servers

2. Init a swarm
3. Join other nodes to the swarm

### Clone this repository

### Set up your secrets

```shell
# The default Graylog secrets, this will result in the admin credentials being
# `admin` for the username and password. In production you should change these.
# Ref: https://docs.graylog.org/docs/docker#settings
printf "somepasswordpepper" | docker secret create graylog_password_secret -
printf "8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918" | docker secret create graylog_root_password_sha2 -
```

To generate a new root password you can execute the following command and copy
the output to the secret above:

```shell
# Linux / Unix / MacOS
$ echo -n "Enter Password: " && head -1 < /dev/stdin | tr -d '\n' | sha256sum | cut -d " " -f1

Enter Password: admin
8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918

# Windows Powershell
$ "admin" | Get-Hash -Algorithm SHA256

Algorithm: SHA256


Path       :
HashString : 8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918
```

`sha256sum` may not be available by default on your system depending on your 
operating system. You can easily install it using one of the following:

- Mac: `brew install coreutils`
- Debian: `apt-get install coreutils`
- Ubuntu: `apt-get install coreutils`
- Alpine: `apk add coreutils`
- Arch Linux: `pacman -S coreutils`
- Kali Linux: `apt-get install coreutils`
- CentOS: `yum install coreutils`
- Fedora: `dnf install coreutils`
- Raspbian: `apt-get install coreutils`
- Dockerfile: [dockerfile.run/sha256sum](https://dockerfile.run/sha256sum)
- Docker: `docker run cmd.cat/sha256sum sha256sum`
- Windows: [https://github.com/Pscx/Pscx](https://github.com/Pscx/Pscx)

### Deploy your cluster

`docker stack deploy --prune -c docker-compose.yml graylog`

## Quick start (CI/CD)

TODO

### Gitlab

### Github


[1]: https://docs.docker.com/engine/swarm/admin_guide/#maintain-the-quorum-of-managers
