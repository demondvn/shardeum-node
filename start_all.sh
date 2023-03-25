#!/bin/bash

# Get the names of all running Docker containers that start with "shardeum-node"
docker ps --format '{{.Names}}' | grep '^shardeum-node' | while read docker_name; do
        echo "Check $docker_name"

  # Send a curl command to the container to load a file
  docker exec $docker_name /bin/bash -c 'curl -s 127.0.0.1:$SHMEXT/load'        
  # Check the exit code of the previous command. If it failed, start the operator-cli
  if [ $? -ne 0 ]; then
        echo "Start $docker_name"
    docker exec $docker_name operator-cli start
  fi
echo ""
done