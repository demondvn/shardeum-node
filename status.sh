#!/bin/bash

docker ps --format '{{.Names}}' | grep '^shardeum-node' | while read docker_name; do
  echo "########## ${docker_name} #########"
  docker exec "${docker_name}" operator-cli status | grep 'state\|totalTimeRunning\|earnings\|lockedStake\|nominatorAddress'
  echo ""
done
