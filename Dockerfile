FROM buildpack-deps:jessie-scm

MAINTAINER zhuxiaole

ENV SERVER_ADDR     0.0.0.0
ENV SERVER_PORT     51348
ENV PASSWORD        psw
ENV METHOD          rc4-md5
ENV PROTOCOL        auth_sha1_v4
ENV PROTOCOLPARAM   32
ENV OBFS            tls1.2_ticket_auth
ENV TIMEOUT         300
ENV DNS_ADDR        8.8.8.8
ENV DNS_ADDR_2      8.8.4.4

ARG BRANCH=manyuser
ARG WORK=~

RUN apt-get update
RUN apt-get install -y python
RUN apt-get install -y libsodium
RUN apt-get install -y wget

ADD start.sh /start.sh
RUN chmod a+x /*.sh

RUN mkdir -p $WORK && \
    wget -qO- --no-check-certificate https://github.com/koolshare/shadowsocksr/archive/$BRANCH.tar.gz | tar -xzf - -C $WORK


WORKDIR $WORK/shadowsocksr-$BRANCH/shadowsocks


EXPOSE $SERVER_PORT

CMD ["/start.sh"]