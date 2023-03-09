#!/bin/bash


# SHMINT=10001
# SHMEXT=9001
docker ps --format '{{.Names}}' | grep '^shardeum-node' | while read docker_name; do
#       docker exec "${docker_name}" cp cli/build/config.json validator/config.json
      screen -dmS "${docker_name}" bash -c "docker exec ${docker_name} /bin/bash -c 'cd cli && git pull && npm i' >> fix.log"
      echo "${docker_name} done"
#     container_number=$(echo $docker_name | sed 's/[^0-9]*//g')
#     docker exec "${docker_name}" sed -i "s/\"externalPort\": *[0-9]\+/\"externalPort\": $((container_number + SHMEXT))/g" /node/validator/config.json
#     docker exec "${docker_name}" sed -i "s/\"internalPort\": *[0-9]\+/\"internalPort\": $((container_number + SHMINT))/g" /node/validator/config.json
done
echo "Fix done"

# SHMINT=10001
# SHMEXT=9001
# docker_name="shardeum-node-15"
# container_number=$(echo $docker_name | sed 's/[^0-9]*//g')
# docker exec "${docker_name}" sed -i "s/\"externalPort\": *[0-9]\+/\"externalPort\": $((container_number+ SHMEXT))/g" /node/validator/config.json
