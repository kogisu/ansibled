.PHONY: all build_image create_network a6d_up a6d_down exec create_nodes

all: create_nodes

build_image:
	docker build -t dind -f `pwd`/dockerfiles/controller.Dockerfile .

a6d_up: build_image create_network
	docker run --privileged --name a6d -d \
    --network a6d-network --network-alias docker \
    -e DOCKER_TLS_CERTDIR=/certs \
    -v some-docker-certs-ca:/certs/ca \
    -v some-docker-certs-client:/certs/client \
		-v `pwd`:/ansibled \
    dind

create_network:
	docker network create a6d-network

a6d_down:
	docker stop dind | echo "ignoring"
	docker rm dind | echo "ignoring"
	docker network rm a6d-network
exec:
	docker exec -it a6d sh

create_nodes: a6d_up
	sleep 2
	docker exec -it a6d docker build -t ubuntu-ssh ansibled/dockerfiles
	docker exec -it a6d docker run -it -d ubuntu-ssh
	docker exec -it a6d docker run -it -d ubuntu-ssh
	docker exec -it a6d docker run -it -d ubuntu-ssh