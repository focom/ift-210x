#!/bin/bash
sudo rm -rf /var/named/*
sudo rm /etc/named/named.conf
sudo cp named.conf /etc/named/
sudo cp -r ./* -t /var/named
sudo chmod -R 777 /var/named
sudo chgrp -R named /var/named/
sudo chgrp -R named /etc/named/
systemctl restart named
systemctl status named
