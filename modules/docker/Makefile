docker/%: IMAGE_NAME := $(shell basename $(PROJECT_ROOT)):latest

## Builds the tardigrade-ci docker image
docker/build: GET_IMAGE_ID := docker inspect --type=image -f '{{.Id}}' "$(IMAGE_NAME)" 2> /dev/null || true
docker/build: IMAGE_ID ?= $(shell $(GET_IMAGE_ID))
docker/build: DOCKER_BUILDKIT ?= $(shell [ -z $(TRAVIS) ] && echo "DOCKER_BUILDKIT=1" || echo "DOCKER_BUILDKIT=0";)
docker/build:
	@echo "[$@]: building docker image"
	[ -n "$(IMAGE_ID)" ] && echo "Image present" || \
	$(DOCKER_BUILDKIT) docker build -t $(IMAGE_NAME) -f $(PROJECT_ROOT)Dockerfile .
	@echo "[$@]: Docker image build complete"

# Adds the current Makefile working directory as a bind mount
## Runs the tardigrade-ci docker image
docker/run: DOCKER_RUN_FLAGS ?= --rm
docker/run: AWS_DEFAULT_REGION ?= us-east-1
docker/run: target ?= help
docker/run: docker/build
	@echo "[$@]: Running docker image"
	docker run $(DOCKER_RUN_FLAGS) \
	-v "$(PROJECT_ROOT):/ci-harness/$(PROJECT_NAME)" \
	-v "$(HOME)/.aws:/.aws" \
	-e TERRAFORM_TEST_DIR=$(PROJECT_NAME)/tests \
	-e AWS_DEFAULT_REGION=$(AWS_DEFAULT_REGION) \
	-e AWS_PROFILE=$(AWS_PROFILE) \
	-e AWS_SHARED_CREDENTIALS_FILE=/.aws/credentials \
	-e INCLUDE=/ci-harness/$(PROJECT_NAME)/Makefile \
	-e PROJECT_ROOT=/ci-harness/$(PROJECT_NAME) \
	$(IMAGE_NAME) $(target)

## Cleans local docker environment
docker/clean:
	@echo "[$@]: Cleaning docker environment"
	docker image prune -a -f
	docker system prune -a -f
	@echo "[$@]: cleanup successful"
