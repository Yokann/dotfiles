#!/bin/bash

D=$(dirname $(readlink -f $0))
sudo install -m 755 $D/bt-no-le2m /usr/local/bin/bt-no-le2m
sudo install -m 644 $D/bt-no-le2m.service /etc/systemd/system/bt-no-le2m.service
sudo systemctl daemon-reload
sudo systemctl enable --now bt-no-le2m.service
