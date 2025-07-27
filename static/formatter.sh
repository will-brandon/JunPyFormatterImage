#!/bin/bash

set -e

USAGE='formatter.sh <check | fix>'
SRC_DIR=/mnt/src
OPERATION="${1}"

function usage_error
{
  printf "\e[91mError\e[0m: ${1}\n"
  printf "Usage: ${USAGE}\n"
  exit 1
}

if [ "${OPERATION}" == check ]
then
  black --check "${SRC_DIR}"
  ruff check "${SRC_DIR}"
  pylint "${SRC_DIR}"
  mypy "${SRC_DIR}"
elif [ "${OPERATION}" == fix ]
then
  black --check "${SRC_DIR}"
  ruff check "${SRC_DIR}"
  pylint "${SRC_DIR}"
  mypy "${SRC_DIR}"
else
  usage_error "Invalid operation: '${OPERATION}'"
fi
