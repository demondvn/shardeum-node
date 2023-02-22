# Shardeum node
## Clone
	git clone https://github.com/demondvn/shardeum-node.git
## Install
	cd shardeum-node
	chmod +x *.sh
	./installer.sh

## Run (Append)
	./docker-up.sh

## check
	./status.sh
## Exec shell
	./shell.sh <NODE number>

## Auto start
	echo "*/5 * * * * root $(pwd)/start_all.sh" >> /etc/crontab && /etc/init.d/cron restart

## Update
	cd shardeum-node
	git pull #(if error required commit or stash  Run >>  git stash && git pull )
	chmod +x *.sh
	./docker-build.sh
## Backup & restore
	./backup.sh (check file in backup folder)
	./restore.sh (to restore)
## Clean all node (Only do when upgrade verion)
	./cleanup.sh 