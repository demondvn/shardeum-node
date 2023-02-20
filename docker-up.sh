#!/usr/bin/env bash

# docker-compose-safe() {
#   if command -v docker-compose &>/dev/null; then
#     cmd="docker-compose"
#   elif docker --help | grep -q "compose"; then
#     cmd="docker compose"
#   else
#     echo "docker-compose or docker compose is not installed on this machine"
#     exit 1
#   fi

#   if ! $cmd $@; then
#     echo "Trying again with sudo..."
#     sudo $cmd $@
#   fi
# }
# # docker-compose-safe -f docker-compose.yml up -d --scale "shardeum-dashboard=${SHARDEUM_INSTANCE}"
read -p "How many instance you want: " SHARDEUM_INSTANCE
SHMEXT=9001
SHMINT=10001
for index in $(seq 0 $((SHARDEUM_INSTANCE-1))); do
  echo "$((SHMEXT + index))"
  echo "$((SHMINT + index))"
  docker run -d --rm --name shardeum-node-$(index) -e SHMEXT=$((SHMEXT + index)) -e DASHPASS=P@ssw0rd -e SHMINT=$((SHMINT + index)) -e DASHPORT=8080 \
  -p $((SHMEXT + index)):$((SHMEXT + index)) -p $((SHMINT + index)):$((SHMINT + index)) \
  -e APP_SEEDLIST="archiver-sphinx.shardeum.org" -e APP_MONITOR="monitor-sphinx.shardeum.org" -e APP_IP=auto \
  -e SERVERIP=$(curl https://ipinfo.io/ip) test-dashboard || return
done

# docker run -d --rm --name shardeum-node-3 -e SHMEXT=9001 -e DASHPASS=P@ssw0rd -e SHMINT=10001 -e DASHPORT=8080 \
# -e APP_SEEDLIST="archiver-sphinx.shardeum.org" -e APP_MONITOR="monitor-sphinx.shardeum.org" -e APP_IP=auto \
# -e SERVERIP=$(curl https://ipinfo.io/ip) test-dashboard