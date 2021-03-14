ImageName = testdash-app
ImageVersion = 1.0

GCP_PROJECT_ID ?= premium-guide-300303
GCP_IMAGE_NAME = gcr.io/$(GCP_PROJECT_ID)/$(ImageName):$(ImageVersion)

Dockerfile = Dockerfile

all: create-docker

build:

clean:

create-docker:
	docker build --rm -t $(ImageName):$(ImageVersion) .

stop-docker:
	container_id=`docker ps -a | awk '/$(ImageName)/ { print $$1}'`; \
	if [ ! -z "$${container_id}" ]; then \
	    echo "Stopping the old $(ImageName) container $${container_id}"; \
	    docker container stop $${container_id}; \
	    docker container prune --force; \
	fi;

start-docker: stop-docker
	@echo
	@echo "Visit 'http://<ip>:80/' to access Marketemp Web UI"
	@echo
	@sleep 3
	docker run --rm --name $(ImageName) -p 8080:8080 $(ImageName):$(ImageVersion)

exec_bash:
	container_id=`docker ps -a | awk '/$(ImageName)/ { print $$1}'`; \
	docker exec -it $${container_id} bash

push-to-gcp-registry:
	-docker rmi $(GCP_IMAGE_NAME)
	-docker image prune -f
	docker tag $(ImageName):$(ImageVersion) $(GCP_IMAGE_NAME)
	@echo "Pussing image $(GCP_IMAGE_NAME) to GCP Container Registry ..."
	docker push $(GCP_IMAGE_NAME)
