#!/bin/sh
/UDPSPEEDER_MODE_$UDPSPEEDER_MODE.sh
/udp2raw/udp2raw_amd64 -s -l0.0.0.0:$UDP2RAW_PORT  -r127.0.0.1:$UDPSPEEDER_PORT   -a -k "$UDP2RAW_PASSWORD" --raw-mode faketcp --cipher-mode xor &
python /shadowsocksr-manyuser/shadowsocks/server.py -p $SERVER_PORT -k $PASSWORD -m $METHOD -O $PROTOCOL -o $OBFS -G $PROTOCOLPARAM