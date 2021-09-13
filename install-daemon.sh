#!/bin/bash -euf

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
