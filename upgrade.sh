read -p "How Many Node? " NODE_NUM
./update.sh
./cleanup.sh
./docker-build.sh
echo -e "${NODE_NUM}/n0/n" | ./docker-up.sh
./restore.sh
