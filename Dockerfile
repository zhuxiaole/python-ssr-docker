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

RUN apt-get update
RUN apt-get install -y python
RUN apt-get install -y wget
RUN apt-get install -y build-essential

RUN wget -qO- --no-check-certificate https://github.com/shadowsocksrr/shadowsocksr/archive/3.2.2.tar.gz | tar -xzf - -C /

RUN wget -qO- --no-check-certificate https://download.libsodium.org/libsodium/releases/LATEST.tar.gz | tar -xzf - -C /
WORKDIR /libsodium-stable
RUN ./configure && make -j2 && make install
RUN ldconfig

ADD start.sh /start.sh
RUN chmod a+x /*.sh


EXPOSE $SERVER_PORT

CMD ["/start.sh"]