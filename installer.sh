#!/bin/bash

# Check all things that will be needed for this script to succeed like access to docker and docker-compose
# If any check fails exit with a message on what the user needs to do to fix the problem
command -v docker >/dev/null 2>&1 || { echo >&2 "'docker' is required but not installed. See https://gitlab.com/shardeum/validator/dashboard/-/tree/dashboard-gui-nextjs#how-to for details."; exit 1; }
command -v docker-compose >/dev/null 2>&1 || { echo >&2 "'docker-compose' is required but not installed. See https://gitlab.com/shardeum/validator/dashboard/-/tree/dashboard-gui-nextjs#how-to for details."; exit 1; }

cat << EOF

#########################
# 0. GET INFO FROM USER #
#########################

EOF

read -p "Do you want to run the web based Dashboard? (y/n): " RUNDASHBOARD
RUNDASHBOARD=${RUNDASHBOARD:-y}

read -p "Set the password to access the Dashboard: " -s DASHPASS
echo

read -p "Dashboard can be accessed at localhost:8080. Use another port? (1025-65536): " DASHPORT
DASHPORT=${DASHPORT:-8080}

read -p "What base directory should the node use (defaults to ~/.shardeum): " NODEHOME
NODEHOME=${NODEHOME:-~/.shardeum}

# read -p "What is the IP of this node?: " APPIP

read -p "What is the IP of the archiver?: " APPSEEDLIST

read -p "What is the IP of the monitor?: " APPMONITOR

echo

cat <<EOF

###########################
# 1. Pull Compose Project #
###########################

EOF

git clone -b dashboard-gui-nextjs https://gitlab.com/shardeum/validator/dashboard.git ${NODEHOME} &&
  cd ${NODEHOME} &&
  chmod a+x ./*.sh

cat <<EOF

#########################
# 2. Building base image #
#########################

EOF

cd ${NODEHOME} &&
docker build --no-cache -t test-dashboard -f Dockerfile --build-arg RUNDASHBOARD=${RUNDASHBOARD} .

cat <<EOF

###############################
# 3. Create and Set .env File #
###############################

EOF

cd ${NODEHOME} &&
touch ./.env
cat >./.env <<EOL
APP_IP=auto
APP_SEEDLIST=${APPSEEDLIST}
APP_MONITOR=${APPMONITOR}
EOL

cat <<EOF

############################
# 4. Start Compose Project #
############################

EOF

cd ${NODEHOME} &&

./docker-up.sh

echo "Starting image."
(docker logs -f shardeum-dashboard &) | grep -q 'done'

echo "Please run ${NODEHOME}/shell.sh for next steps."
