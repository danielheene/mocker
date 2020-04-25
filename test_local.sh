#!/usr/bin/env bash

VERSION="latest"
IMAGE="dnsdrone-mocker"

SPAWN_PERSISTENT="${SPAWN_PERSISTENT:=2}"
SPAWN_DYNAMIC="${SPAWN_DYNAMIC:=3}"
SPAWN_MIN_LIFESPAN="${SPAWN_MIN_LIFESPAN:=1}"
SPAWN_MAX_LIFESPAN="${SPAWN_MAX_LIFESPAN:=3}"

echo
tput bold; tput setaf 2;
echo "► BUILDING IMAGE:"
tput sgr0; tput setaf 2;
echo "──────────────────────────────────────"
tput sgr0
docker build \
    --build-arg VERSION=${VERSION} \
    --build-arg IMAGE=${IMAGE} \
    --tag ${IMAGE}:${VERSION} . | awk '{print "  "$0""}'

echo
tput bold; tput setaf 2;
echo "► RUNNING SEEDER:"
tput sgr0; tput setaf 2;
echo "──────────────────────────────────────"
tput sgr0
docker run --rm -ti \
    -v "/var/run/docker.sock:/var/run/docker.sock" \
    -e "SPAWN_PERSISTENT=${SPAWN_PERSISTENT}" \
    -e "SPAWN_DYNAMIC=${SPAWN_DYNAMIC}" \
    -e "SPAWN_MIN_LIFESPAN=${SPAWN_MIN_LIFESPAN}" \
    -e "SPAWN_MAX_LIFESPAN=${SPAWN_MAX_LIFESPAN}" \
    --name "dnsdrone-seeder" \
    ${IMAGE}:${VERSION} \
    seed | awk '{print "  "$0""}'
