#!/bin/bash

/usr/bin/lsyncd -log all -logfile /etc/lsyncd/lsyncd.log -insist -pidfile /var/run/lsyncd.pid /etc/lsyncd/lsyncd.conf.lua

bash