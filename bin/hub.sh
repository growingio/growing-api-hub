#!/bin/bash

source /etc/profile
mkdir -p logs
nginx -p `pwd` -c conf/nginx.conf $@