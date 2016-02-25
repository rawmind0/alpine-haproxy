FROM rawmind/alpine-base:0.3.3-2
MAINTAINER Raul Sanchez <rawmind@gmail.com>

ENV HAPROXY_HOME /opt/haproxy
ENV PATH=$PATH:${HAPROXY_HOME}/bin

# Compile and install haproxy
RUN set -ex && \
    apk --update add iptables iproute2 libnl3-cli musl-dev linux-headers gcc pcre-dev make zlib-dev openssl-dev && \
    mkdir -p /opt/src ${HAPROXY_HOME}/etc/ssl ${HAPROXY_HOME}/bin && \
    curl -fL http://www.haproxy.org/download/1.6/src/haproxy-1.6.3.tar.gz | tar xzf - -C /opt/src && \
    cd /opt/src/haproxy-1.6.3 && \
    make TARGET=linux2628 USE_PCRE=1 USE_ZLIB=1 USE_OPENSSL=1 && \
    cp -p haproxy ${HAPROXY_HOME}/bin && \
    cd ${HAPROXY_HOME} && \
    rm -rf /opt/src && \
    apk del musl-dev linux-headers gcc pcre-dev make zlib-dev openssl-dev && \
    apk add musl pcre zlib && rm /var/cache/apk/*

# Add haproxy.sh and default haproxy.cfg
ADD haproxy.sh ${HAPROXY_HOME}/bin/
RUN chmod +x ${HAPROXY_HOME}/bin/*
ADD haproxy.cfg ${HAPROXY_HOME}/etc/

WORKDIR ${HAPROXY_HOME}

ENTRYPOINT ["/opt/haproxy/bin/haproxy.sh","start"]
