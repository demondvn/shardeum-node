#!/bin/bash

docker ps --format '{{.Names}}' | grep '^shardeum-node' | while read docker_name; do
  # port=$(docker exec "${docker_name}" operator-cli status | grep 'checkPort' | awk '{print $2}')
  # echo "$docker_name port open: $port"
  # if [[ "$port" == "false" ]]; then
    # echo "START SHARDEUM"
    echo "Stop ${docker_name}"
    docker exec "${docker_name}" operator-cli stop
    # docker exec "${docker_name}" sh -c 'operator-cli set external_port $SHMEXT'
    # docker exec "${docker_name}" sh -c 'operator-cli set internal_port $SHMINT'
  # fi
  
done
