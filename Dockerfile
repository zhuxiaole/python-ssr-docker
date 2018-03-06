FROM buildpack-deps:jessie-scm

MAINTAINER zhuxiaole

ENV SERVER_ADDR     0.0.0.0
ENV SERVER_PORT     51348
ENV PASSWORD        psw
ENV METHOD          chacha20
ENV PROTOCOL        auth_sha1_v4
ENV PROTOCOLPARAM   32
ENV OBFS            tls1.2_ticket_auth
ENV TIMEOUT         300
ENV DNS_ADDR        8.8.8.8
ENV DNS_ADDR_2      8.8.4.4

#GAME: 游戏（3倍流量）  2: NORMAL（视频、下载、网页，1.5倍流量） 3: COMPROMISE（折中，1.6倍流量） 4: GAME_NO_LIMIT（大于3倍流量）
ENV UDPSPEEDER_MODE GAME
ENV UDPSPEEDER_VERSION v2@20171125.0
ENV UDPSPEEDER_PORT 4096
ENV UDPSPEEDER_PASSWORD psw

ENV UDP2RAW_VERSION 20180225.0
ENV UDP2RAW_PORT 7123
ENV UDP2RAW_PASSWORD psw

RUN apt-get update
RUN apt-get install -y python
RUN apt-get install -y wget
RUN apt-get install -y build-essential

RUN wget -qO- --no-check-certificate https://github.com/koolshare/shadowsocksr/archive/manyuser.tar.gz | tar -xzf - -C /

RUN wget -qO- --no-check-certificate https://download.libsodium.org/libsodium/releases/LATEST.tar.gz | tar -xzf - -C /
WORKDIR /libsodium-stable
RUN ./configure && make -j2 && make install
RUN ldconfig

RUN mkdir /udpspeeder
RUN wget -qO- --no-check-certificate https://github.com/wangyu-/UDPspeeder/releases/download/$UDPSPEEDER_VERSION/speederv2_binaries.tar.gz | tar -xzf - -C /udpspeeder/

RUN mkdir /udp2raw
RUN wget -qO- --no-check-certificate https://github.com/wangyu-/udp2raw-tunnel/releases/download/$UDP2RAW_VERSION/udp2raw_binaries.tar.gz | tar -xzf - -C /udp2raw/


ADD start.sh /start.sh
RUN chmod a+x /*.sh

EXPOSE $UDPSPEEDER_PORT
EXPOSE $UDP2RAW_PORT
EXPOSE $SERVER_PORT

CMD ["/start.sh"]