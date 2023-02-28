#!/bin/bash
if ! command -v screen &> /dev/null
then
    echo "screen is not installed. Installing..."
    sudo apt-get install screen -y
fi
current_time=$(date "+%Y-%m-%d %H:%M:%S")
echo "${current_time}" > log
docker ps --format '{{.Names}}' | grep '^shardeum-node' | while read docker_name; do
  screen -dmS "${docker_name}" bash -c " ./_start.sh ${docker_name} >> start.log"
done
echo "\`cat start.log\` to more detail"
sleep 30
tail start.log 