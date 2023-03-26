#!/bin/bash
if ! command -v screen &> /dev/null
then
    echo "screen is not installed. Installing..."
    sudo apt-get install screen
fi
current_time=$(date "+%Y-%m-%d %H:%M:%S")
echo "${current_time}" > log
trap out SIGINT
function out(){
echo -e "\nActive Node: $(cat log | grep -c 'active')"
echo -e "Standby Node: $(cat log | grep -c 'standby')"
echo -e "Total earning: $(cat log | grep 'currentRewards' | sed -E 's/.*[^0-9\.]([0-9\.]+)[^0-9\.]*$/\1/' | awk '{s+=$1} END {print s}')"
echo "############################################"
echo "# Get list Active run                      #"
echo "# cat log | grep active -B 2 -A 5          #"
echo "# Get list Not staked                      #"
echo "# cat log | grep \"''\" -B 2 -A 5          #"
echo "############################################"
exit 1
}
docker ps --format '{{.Names}}' | grep '^shardeum-node' | while read docker_name; do
    screen -dmS "${docker_name}" bash -c " ./_status.sh ${docker_name} >> log"
done
#sleep 5
tail -f log
