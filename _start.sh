#!/bin/bash
docker_name=$1
state=$(docker exec "${docker_name}" operator-cli status | grep 'state' | awk '{print $2}')
  echo "$docker_name : $state"
  if [[ "$state" == "stopped" ]]; then
    echo "START SHARDEUM"
    docker exec "${docker_name}" operator-cli start
    docker exec "${docker_name}" sh -c 'operator-cli set external_port $SHMEXT'
    docker exec "${docker_name}" sh -c 'operator-cli set internal_port $SHMINT'
  fi