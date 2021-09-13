#!/bin/bash -euf

if [ ! -f "/usr/bin/node" ]; then
	printf "/usr/bin/node not available. Please install nodejs.\n" >&2
	exit 1
fi

if [ ! -f "/usr/bin/curl" ]; then
	printf "/usr/bin/curl not available. Please install curl.\n" >&2
	exit 1
fi

./uninstall-daemon.sh &> /dev/null

source ./vars.sh

printf "Compiling ... "
rm -f send-serial
gcc -Wall -Wpedantic sendSerial.c -o send-serial
sudo mv send-serial "$BIN_DEST_PATH-send-serial"
sudo chown root:root "$BIN_DEST_PATH-send-serial"
sudo chmod u+s "$BIN_DEST_PATH-send-serial"
printf "done\n"

sudo cp systemd.service "$SERVICE_DEST_PATH"
sudo cp main.js "$BIN_DEST_PATH"

sudo systemctl start "$SERVICE_NAME"
sudo systemctl enable "$SERVICE_NAME"

printf "SUCCESSFULLY INSTALLED\n"
