#!/bin/sh
if [ "$UDPSPEEDER_MODE"x = "GAME"x ]; then
	/udpspeeder/speederv2_amd64 -s -l0.0.0.0:$UDPSPEEDER_PORT -r127.0.0.1:$SERVER_PORT   -k "$UDPSPEEDER_PASSWORD"  -f2:4 --timeout 1 &
fi
if [ "$UDPSPEEDER_MODE"x = "NORMAL"x ]; then
	/udpspeeder/speederv2_amd64 -s -l0.0.0.0:$UDPSPEEDER_PORT -r127.0.0.1:$SERVER_PORT   -k "$UDPSPEEDER_PASSWORD"  -f20:10 --timeout 8 &
fi
if [ "$UDPSPEEDER_MODE"x = "COMPROMISE"x ]; then
	/udpspeeder/speederv2_amd64 -s -l0.0.0.0:$UDPSPEEDER_PORT -r127.0.0.1:$SERVER_PORT   -k "$UDPSPEEDER_PASSWORD"  -f10:6 --timeout 3 &
fi
if [ "$UDPSPEEDER_MODE"x = "GAME_NO_LIMIT"x ]; then
	/udpspeeder/speederv2_amd64 -s -l0.0.0.0:$UDPSPEEDER_PORT -r127.0.0.1:$SERVER_PORT   -k "$UDPSPEEDER_PASSWORD"  -f2:4 --timeout 0 &
fi

/udp2raw/udp2raw_amd64 -s -l0.0.0.0:$UDP2RAW_PORT  -r127.0.0.1:$UDPSPEEDER_PORT   -a -k "$UDP2RAW_PASSWORD" --raw-mode faketcp --cipher-mode xor &

python /shadowsocksr-manyuser/shadowsocks/server.py -p $SERVER_PORT -k $PASSWORD -m $METHOD -O $PROTOCOL -o $OBFS -G $PROTOCOLPARAM