FROM alpine

ARG PASSWORD=secret

ENV SERVER_ADDR 0.0.0.0
ENV PASSWORD    ${PASSWORD}}
ENV METHOD      aes-256-cfb
ENV TIMEOUT     300
ENV DNS_ADDR    8.8.8.8
ENV DNS_ADDR_2  8.8.4.4
ENV ARGS=

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories

RUN set -ex \
 # Build environment setup
 && apk add --no-cache --virtual .build-deps \
      autoconf \
      automake \
      build-base \
      c-ares-dev \
      libev-dev \
      libtool \
      libsodium-dev \
      linux-headers \
      mbedtls-dev \
      pcre-dev
 # Build & install
 COPY ./packages ./
 RUN tar -zxf shadowsocks-libev-3.1.3.tar.gz \
    && cd shadowsocks-libev-3.1.3 \
    && ./configure --prefix=/usr --disable-documentation \
    && make install \
    && apk del .build-deps \
    # Runtime dependencies setup
    && apk add --no-cache \
        rng-tools \
        $(scanelf --needed --nobanner /usr/bin/ss-* \
        | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
        | sort -u) \
    && rm -rf shadowsocks-libev-3.1.3

USER nobody

EXPOSE 8388/tcp 8388/udp

CMD exec ss-server \
      -s $SERVER_ADDR \
      -p 8388 \
      -k ${PASSWORD:-$(hostname)} \
      -m $METHOD \
      -t $TIMEOUT \
      --fast-open \
      -d $DNS_ADDR \
      -d $DNS_ADDR_2 \
      -u \
      $ARGS