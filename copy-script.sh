#!/bin/bash
su
rm -rf /var/named/*
rm /etc/named/named.con
cp named.conf /etc/named/
cp -r ./* -t /var/named
chmod -R 777 /var/named
chgrp -R named /var/named/
chgrp -R named /etc/named/
systemctl restart named
