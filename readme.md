# Ansibled

Ansible in docker.

## About

This project deploys a docker network with 3 ubuntu - based docker inside a docker container (dind)

Each of the nodes in the container are ssh-enabled which allows developers to create ansible scripts and test locally. This script creates a full dev environment for ansible in under a minute.

## Architecture

![Architecture diagram](./diagram.svg)

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
make dind_down
```
