# a6d

ansible in docker.

## About

This project deploys a docker network consisting of 3 ubuntu-based docker containers inside a alpine-linux docker container (dind)

Each of the nodes in the alpine container are ssh-enabled which allows developers to create and test their ansible scripts. This creates a full dev environment for ansible in under a minute.

### Docker Version

```
Client: Docker Engine - Community
 Version:           19.03.13
 API version:       1.40
 Go version:        go1.13.15
```

### Controller Node

Controller is running `alpine linux` and comes preloaded with `docker` and `ansible`

### Worker Nodes

Nodes are running `Ubuntu 20.04`

## Architecture

![Architecture diagram](./diagrams/diagram.svg)

## Requirements

docker

## Usage

To set up the environment, run the following:

```sh
$ make
# yep... that's it!!
```

Exec into the container

```sh
docker exec -it a6d sh
```

Get running ubuntu containers

```sh
/ # docker ps
CONTAINER ID        IMAGE               COMMAND               CREATED             STATUS              PORTS               NAMES
6173c6ea2609        ubuntu-ssh          "/usr/sbin/sshd -D"   18 seconds ago      Up 18 seconds       22/tcp              intelligent_diffie
aa6057fd3571        ubuntu-ssh          "/usr/sbin/sshd -D"   19 seconds ago      Up 19 seconds       22/tcp              priceless_edison
385580ebc68b        ubuntu-ssh          "/usr/sbin/sshd -D"   19 seconds ago      Up 19 seconds       22/tcp              nice_heisenberg
```

To bring down the network, run

```
make a6d_down
```

## IP addresses

docker creates an IP for each docker container in the network. To determine the IP addresses for each of the containers running on your machine, run for each container

```sh
$ docker inspect <docker-container-hash>
```

Under the `Networks` section, look for the `IPAddress`

```json
"Networks": {
  "bridge": {
    ...
    "IPAddress": "172.17.0.4",
    ...
  }
}
```
