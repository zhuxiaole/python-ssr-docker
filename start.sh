#!/bin/sh

python $WORK/shadowsocksr-$SSR_VERSION/shadowsocks/server.py -p $SERVER_PORT -k $PASSWORD -m $METHOD -O $PROTOCOL -o $OBFS -G $PROTOCOLPARAM
