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

## Setup

To set up the environment, run the following:

```sh
$ make
# yep... that's it!!
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
