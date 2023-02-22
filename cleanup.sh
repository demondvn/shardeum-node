#!/bin/bash

docker ps --format '{{.Names}}' | grep '^shardeum-node' | while read docker_name; do
  echo "Remove ${docker_name} | $(docker exec "${docker_name}" cat validator/package.json | grep version)"
  docker rm -f "${docker_name}" 
  echo "remove ${docker_name}"
done
docker image rm -f test-dashboard
