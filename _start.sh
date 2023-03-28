#!/bin/bash

# Get the names of all running Docker containers that start with "shardeum-node"
docker ps --format '{{.Names}}' | grep '^shardeum-node' | while read docker_name; do
        echo "Check $docker_name"
  docker exec $docker_name operator-cli start
  # Send a curl command to the container to load a file
  
echo ""
done