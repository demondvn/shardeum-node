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
read -p "How many instance you want (max 100): " SHARDEUM_INSTANCE
read -p "Start from:(0) " START_FROM
EXISTING_ARCHIVERS='[{"ip":"18.194.3.6","port":4000,"publicKey":"758b1c119412298802cd28dbfa394cdfeecc4074492d60844cc192d632d84de3"},{"ip":"139.144.19.178","port":4000,"publicKey":"840e7b59a95d3c5f5044f4bc62ab9fa94bc107d391001141410983502e3cde63"},{"ip":"139.144.43.47","port":4000,"publicKey":"7af699dd711074eb96a8d1103e32b589e511613ebb0c6a789a9e8791b2b05f34"},{"ip":"72.14.178.106","port":4000,"publicKey":"2db7c949632d26b87d7e7a5a4ad41c306f63ee972655121a37c5e4f52b00a542"}]'
SHMEXT=9001
SHMINT=10001
# SERVERIP=$(curl https://ipinfo.io/ip)
docker network create --driver bridge shardeum-net
for index in $(seq $START_FROM $((START_FROM+SHARDEUM_INSTANCE-1))); do
  echo "$((SHMEXT + index))"
  echo "$((SHMINT + index))"
  docker run -d --restart unless-stopped --network shardeum-net --name shardeum-node-$index -e SHMEXT=$((SHMEXT + index))  -e SHMINT=$((SHMINT + index)) \
  -p $((SHMEXT + index)):$((SHMEXT + index)) -p $((SHMINT + index)):$((SHMINT + index)) \
  -e APP_SEEDLIST="archiver-sphinx.shardeum.org" -e APP_MONITOR="monitor-sphinx.shardeum.org" -e APP_IP=auto \
  -e EXISTING_ARCHIVERS=$EXISTING_ARCHIVERS test-dashboard || continue
  echo "Start shardeum-node-$index Success"
done

# docker run -d --rm --name shardeum-node-3 -e SHMEXT=9001 -e DASHPASS=P@ssw0rd -e SHMINT=10001 -e DASHPORT=8080 \
# -e APP_SEEDLIST="archiver-sphinx.shardeum.org" -e APP_MONITOR="monitor-sphinx.shardeum.org" -e APP_IP=auto \
# -e SERVERIP=$(curl https://ipinfo.io/ip) test-dashboard
