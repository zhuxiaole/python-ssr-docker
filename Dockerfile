FROM debian:latest

MAINTAINER zhuxiaole


#Download applications
RUN apt-get update \
    && apt-get install -y libsodium-dev python git ca-certificates iptables --no-install-recommends


#Make ssr-mudb
ENV PORT="465" \
    PASSWORD="ssr-bbr-docker" \
    METHOD="rc4-md5" \
    PROTOCOL="auth_sha1_v4" \
    OBFS="tls1.2_ticket_auth"

RUN git clone -b akkariiin/master https://github.com/letssudormrf/shadowsocksr.git \
    && cd shadowsocksr \
    && bash initcfg.sh \
    && sed -i 's/sspanelv2/mudbjson/' userapiconfig.py \
    && python mujson_mgr.py -a -u MUDB -p ${PORT} -k ${PASSWORD} -m ${METHOD} -O ${PROTOCOL} -o ${OBFS} -G "#"


#Execution environment
COPY start.sh /root/
RUN chmod a+x /root/start.sh
WORKDIR /shadowsocksr
ENTRYPOINT ["/root/start.sh"]
CMD /root/start.sh