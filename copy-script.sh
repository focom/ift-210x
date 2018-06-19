#!/bin/bash
rm -rf /var/named/*
rm /etc/named/named.con
cp named.conf /etc/named/
cp -r ./* -t /var/named
