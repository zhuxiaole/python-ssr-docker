#!/bin/sh
if [ "${UDPSPEEDER_MODE}" == "GAME" ]; then
	./speederv2 -s -l0.0.0.0:$UDPSPEEDER_PORT -r127.0.0.1:$SERVER_PORT   -k "$UDPSPEEDER_PASSWORD"  -f2:4 --timeout 1
fi
if [ "${UDPSPEEDER_MODE}" == "NORMAL" ]; then
	./speederv2 -s -l0.0.0.0:$UDPSPEEDER_PORT -r127.0.0.1:$SERVER_PORT   -k "$UDPSPEEDER_PASSWORD"  -f20:10 --timeout 8
fi
if [ "${UDPSPEEDER_MODE}" == "COMPROMISE" ]; then
	./speederv2 -s -l0.0.0.0:$UDPSPEEDER_PORT -r127.0.0.1:$SERVER_PORT   -k "$UDPSPEEDER_PASSWORD"  -f10:6 --timeout 3
fi
if [ "${UDPSPEEDER_MODE}" == "GAME_NO_LIMIT" ]; then
	./speederv2 -s -l0.0.0.0:$UDPSPEEDER_PORT -r127.0.0.1:$SERVER_PORT   -k "$UDPSPEEDER_PASSWORD"  -f2:4 --timeout 0
fi

./udp2raw_amd64 -s -l0.0.0.0:$UDP2RAW_PORT  -r127.0.0.1:$UDPSPEEDER_PORT   -a -k "$UDP2RAW_PASSWORD" --raw-mode faketcp --cipher-mode xor

python /shadowsocksr-manyuser/shadowsocks/server.py -p $SERVER_PORT -k $PASSWORD -m $METHOD -O $PROTOCOL -o $OBFS -G $PROTOCOLPARAM