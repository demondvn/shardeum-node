#!/usr/bin/env bash
NODE = $1
if [[!"$NODE"]]then
  read -p "Insert node number: "NODE
if
docker exec -it "shardeum-dashboard-$NODE" /bin/bash