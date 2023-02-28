#!/bin/bash
echo "######## $1 $(docker exec "$1" cat validator/package.json | grep version) ########"
docker exec "$1" operator-cli status | grep "state\|totalTimeRunning\|earnings:\|nominatorAddress\|nomineeAddress"
