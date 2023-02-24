#!/bin/bash

if [ -n "$1" ]; then
  number=$1
else
  read -p "Please enter a number: " number
fi

while ! docker exec "shardeum-node-$number" operator-cli stake 10.1 | grep -q byzantium: true; do
  docker exec "shardeum-node-$number" operator-cli stake 10.1
done
