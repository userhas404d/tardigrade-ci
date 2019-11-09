#!/usr/local/bin/bash

# Only run Makefile unit tests if change is detected in TRIGGER_FILES

DOCKER_BUILD=
CHANGED_FILES=("$( git diff "$TRAVIS_COMMIT_RANGE" --name-only )")
TRIGGER_FILES=("Makefile" ".bats" "Dockerfile")
for FILE in "${CHANGED_FILES[@]}";
do
  for TRIGGER in "${TRIGGER_FILES[@]}";
    do
      if [[ "$FILE" == *"$TRIGGER"* ]]
      then
        echo "found change in $FILE"
        DOCKER_BUILD=1
      fi
    done
done
if [ -n "$DOCKER_BUILD" ]
then
  docker build -t "$IMAGE_NAME" .
fi
