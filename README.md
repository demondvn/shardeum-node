# Shardeum node
## Clone
	git clone https://github.com/demondvn/shardeum-node.git
## Install
	cd shardeum-node
	chmod +x *.sh
	./installer.sh

## Run (Append)
	./docker-up.sh

## Auto start
	echo '*/5 * * * *  /usr/bin/sh $pwd/start_all.sh' >> /etc/crontab && /etc/init.d/cron restart
