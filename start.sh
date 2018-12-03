#!/bin/sh

nohup python /shadowsocksr-manyuser/shadowsocks/server.py -p $SERVER_PORT -k $PASSWORD -m $METHOD -O $PROTOCOL -o $OBFS -G $PROTOCOLPARAM >> ssserver.log 2>&1 &