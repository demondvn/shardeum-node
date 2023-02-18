#!/usr/bin/env bash

docker-compose-safe() {
  if command -v docker-compose &>/dev/null; then
    cmd="docker-compose"
  elif docker --help | grep -q "compose"; then
    cmd="docker compose"
  else
    echo "docker-compose or docker compose is not installed on this machine"
    exit 1
  fi

  if ! $cmd $@; then
    echo "Trying again with sudo..."
    sudo $cmd $@
  fi
}
read -p "How many instance you want (max 100): " SHARDEUM_INSTANCE
docker-compose-safe -f docker-compose.yml up -d --scale "shardeum-dashboard=${SHARDEUM_INSTANCE}"
