#!/usr/bin/env bash

set -e


get_target_dirs() {
  # create an array of all unique directories containing requirements.txt files
  # within this project
  PROJECT_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )"/.. >/dev/null 2>&1 && pwd )
  mapfile -t directories < <(find "$PROJECT_DIR" -name 'requirements.txt' -exec dirname {} \; | sort -u | grep -v "\.terraform\b\|\.terragrunt-cache\b")
}

build_image() {
  echo "$(tput setaf 2)=> building image from $DOCKERFILE$(tput sgr0)"
  docker build -t "$IMAGE_NAME" -f "$DOCKERFILE" .
}


docker_image_check() {
  # validate if the docker image is present on the host machine
  # if not found, create it
  IMAGE_NAME="plus3/ci"
  DOCKERFILE="Dockerfile"

  IMAGE_ID=$(docker inspect --type=image -f '{{.Id}}' "$IMAGE_NAME" 2> /dev/null || true)
  if [ -z "$IMAGE_ID" ]; then
    echo "$(tput setaf 4) > image $IMAGE_NAME doesn't exist$(tput sgr0)"
    build_image
  else
    echo "$(tput setaf 4) > image $IMAGE_NAME already exists$(tput sgr0)"
  fi
}

docker_run() {
  # run docker
  docker_image_check
  get_docker_bindmount_dirs
  DOCKER_BINDMOUNTS+=(-v "$PROJECT_DIR/bin:$CODE_DIR/bin")

  docker run --rm -ti \
    "${DOCKER_BINDMOUNTS[@]}" \
    -w "$CODE_DIR" \
    --cap-add=SYS_PTRACE \
    "$IMAGE_NAME" bash -c './bin/generate-layer.sh -c'
}

while getopts :rc opt
do
    case "${opt}" in
        r)
            # run docker
            docker_run
            ;;
        c)
            # create layers
            create_layers
            ;;
        \?)
            echo "ERROR: unknown parameter \"$OPTARG\""
            exit 1
            ;;
    esac
done
shift $((OPTIND-1))
