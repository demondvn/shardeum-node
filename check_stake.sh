#!/bin/bash

docker ps --format '{{.Names}}' | grep '^shardeum-node' | while read docker_name; do
  echo "########## ${docker_name} ######### "

  docker exec "${docker_name}" operator-cli stake_info 0x0486509810A2dC4c44D4Dc71BE8B97413657cB1f
  echo ""
done
