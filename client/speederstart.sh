#!/bin/sh
if [ -f "/udp2raw/udp2raw_x86" ];then
    echo "udp2raw已安装"
else
    mkdir -p /udp2raw
    read -p "请输入udp2raw版本号（回车跳过）:" UDP2RAW_VERSION
    if  [ ! -n "$UDP2RAW_VERSION" ] ; then
        UDP2RAW_VERSION="20180225.0"
    fi
    wget --no-check-certificate https://github.com/wangyu-/udp2raw-tunnel/releases/download/$UDP2RAW_VERSION/udp2raw_binaries.tar.gz | tar -xzf - -C /udp2raw/
fi

if [ -f "/udpspeeder/speederv2_x86" ];then
    echo "udpspeeder已安装"
else
    mkdir -p /udpspeeder
    read -p "请输入udpspeeder版本号（回车跳过）:" UDPSPEEDER_VERSION
    if  [ ! -n "$UDPSPEEDER_VERSION" ] ; then
        UDPSPEEDER_VERSION="v2@20171125.0"
    fi
    wget --no-check-certificate https://github.com/wangyu-/UDPspeeder/releases/download/$UDPSPEEDER_VERSION/speederv2_binaries.tar.gz | tar -xzf - -C /udpspeeder/
fi

if [ -f "/tinymapper/tinymapper_x86" ];then
    echo "tinymapper已安装"
else
    mkdir -p /tinymapper
    read -p "请输入tinymapper版本号（回车跳过）:" TINYMAPPER_VERSION
    if  [ ! -n "$TINYMAPPER_VERSION" ] ; then
        TINYMAPPER_VERSION="20180224.0"
    fi
    wget --no-check-certificate https://github.com/wangyu-/tinyPortMapper/releases/download/$TINYMAPPER_VERSION/tinymapper_binaries.tar.gz | tar -xzf - -C /tinymapper/
fi

read -p "请输入服务器ip地址:" SERVER_IP
if  [ ! -n "$SERVER_IP" ] ; then
    echo "错误：未输入服务器ip地址！"
    exit 1
fi
read -p "请输入酸酸乳端口:" SSR_PORT
if  [ ! -n "$SSR_PORT" ] ; then
    echo "错误：未输入酸酸乳端口！"
    exit 1
fi
read -p "请输入服务器udp2raw端口:" UDP2RAW_SERVER_PORT
if  [ ! -n "$UDP2RAW_SERVER_PORT" ] ; then
    echo "错误：未输入服务器udp2raw端口！"
    exit 1
fi
read -p "请输入udp2raw密码:" UDP2RAW_PSW
reed -p "请输入udpspeeder密码：" UDPSPEEDER_PSW
read -p "请输入udpspeeder模式（1：普通-默认  2：游戏）:" UDPSPEEDER_MODE
if  [ ! -n "$UDPSPEEDER_MODE" ] ; then
    UDPSPEEDER_MODE=1
fi
/udp2raw/udp2raw_x86 -c -l0.0.0.0:3333  -r$SERVER_IP:$UDP2RAW_SERVER_PORT -a -k "$UDP2RAW_PSW" --raw-mode faketcp --cipher-mode xor &
/udpspeeder/speederv2_x86 -c -l0.0.0.0:6666 -r127.0.0.1:3333 -k "$UDPSPEEDER_PSW" -f2:4 --timeout 1 --mode 0 &
/tinymapper/tinymapper_x86 -l0.0.0.0:6666 -r$SERVER_IP:$SSR_PORT -t