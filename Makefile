.PHONY: all dind create_network terminate_dnd

all: create_nodes

docker_image:
	docker build -t dind -f `pwd`/dockerfiles/controller.Dockerfile .

dind_up: create_network
	docker run --privileged --name dind -d \
    --network dind-network --network-alias docker \
    -e DOCKER_TLS_CERTDIR=/certs \
    -v some-docker-certs-ca:/certs/ca \
    -v some-docker-certs-client:/certs/client \
		-v `pwd`:/ansibled \
    dind

create_network:
	docker network create dind-network

dind_down:
	docker stop dind | echo "ignoring"
	docker rm dind | echo "ignoring"
	docker network rm dind-network
exec:
	docker exec -it dind sh

create_nodes: dind_up
	sleep 2
	docker exec -it dind docker build -t ansibled ansibled/dockerfiles
	docker exec -it dind docker run -it -d ansibled
	docker exec -it dind docker run -it -d ansibled
	docker exec -it dind docker run -it -d ansibled