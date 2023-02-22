#!/bin/bash
read -p "You want to delete all nodes (y/n)? " CONFIRM
if [[ "$CONFIRM" != "y" ]]; then
  exit
fi
echo "Deleting nodes..."
docker ps --format '{{.Names}}' | grep '^shardeum-node' | while read docker_name; do
  echo "Remove ${docker_name} | $(docker exec "${docker_name}" cat validator/package.json | grep version)"
  docker rm -f "${docker_name}" 
  echo "remove ${docker_name}"
done
echo "Delete Image"
docker image rm -f test-dashboard
echo "Delete Complete"