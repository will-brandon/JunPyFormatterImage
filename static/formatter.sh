#!/bin/bash

set -e

USAGE='formatter.sh [check | fix] [SRC DIR]'
OPERATION="${1-check}"
SRC_DIR="${2-"/mnt/src"}"

function timestamp
{
  date '+%Y-%m-%d %H:%M:%S'
}

function usage_error
{
  MSG="${1-"Unknown usage error"}"
  printf "\e[0;91mError\e[0m: ${MSG}\n"
  printf "Usage: ${USAGE}\n"
  exit 1
}

function error
{
  MSG="${1-"Unknown error"}"
  printf "\e[0;91mError\e[0m: ${MSG}\n"
  exit 1
}

function log
{
  MSG="${1}"
  printf "\e[0;1m[FORMATTER $(timestamp)] ${MSG}\e[0m\n"
}

if [ ! -z "${3}" ]
then
  usage_error "Too many arguments provided"
fi

if [ ! -d "${SRC_DIR}" ]
then
  error "Source directory does not exist: ${SRC_DIR}"
fi

if [ "${OPERATION}" == check ]
then
  log "Passively checking formatting..."

  log "Running black checks"
  black --check "${SRC_DIR}"

  log "Running ruff checks"
  ruff check "${SRC_DIR}"

  log "Running pylint checks"
  pylint "${SRC_DIR}"

  log "Running mypy checks"
  mypy "${SRC_DIR}"

  log "Finished checking formatting."
elif [ "${OPERATION}" == fix ]
then
  log "Actively fixing formatting..."

  log "Running black fixes"
  black "${SRC_DIR}"

  log "Running ruff fixes"
  ruff check --fix "${SRC_DIR}"

  log "Running pylint checks"
  pylint "${SRC_DIR}"

  log "Running mypy checks"
  mypy "${SRC_DIR}"

  log "Finished fixing formatting."
else
  usage_error "Invalid operation: '${OPERATION}'"
fi
