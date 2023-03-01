@@ -6,6 +6,8 @@ docker ps --format '{{.Names}}' | grep '^shardeum-node' | while read docker_name
  if [[ "$state" == "stopped" ]]; then
    echo "START SHARDEUM"
    docker exec "${docker_name}" operator-cli start
    docker exec "${docker_name}" sh -c 'operator-cli set external_port $SHMEXT'
    docker exec "${docker_name}" sh -c 'operator-cli set internal_port $SHMINT'
  fi

done