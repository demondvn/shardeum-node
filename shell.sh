#!/bin/bash

if [ -n "$1" ]; then
  number=$1
else
  read -p "Please enter a number: " number
fi
docker exec -it "shardeum-dashboard-$number" /bin/bash