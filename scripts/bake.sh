#!/bin/bash

REPOSITORY=jun-py-formatter
VERSION_INTERFACE=1.0
VERSION="${VERSION_INTERFACE}.0.0"
STATIC_DIR=./static
BUILD_DIR=./.junbuild

mkdir -p "${BUILD_DIR}/docker_images"

if [ -d "${STATIC_DIR}" ]; then
  cp -rp "${STATIC_DIR}/." "${BUILD_DIR}"
fi


docker build -f ./src/Dockerfile -t "${REPOSITORY}:${VERSION}" "${BUILD_DIR}"
docker tag "${REPOSITORY}:${VERSION}" "${REPOSITORY}:${VERSION_INTERFACE}"
docker save -o ./.junbuild/docker_images/${REPOSITORY}_${VERSION}.tar "${REPOSITORY}:${VERSION}"
