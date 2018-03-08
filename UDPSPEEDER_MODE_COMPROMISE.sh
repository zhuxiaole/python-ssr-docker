#!/bin/sh
/udpspeeder/speederv2_amd64 -s -l0.0.0.0:$UDPSPEEDER_PORT -r127.0.0.1:$SERVER_PORT   -k "$UDPSPEEDER_PASSWORD"  -f10:6 --timeout 3 --mode 0 &