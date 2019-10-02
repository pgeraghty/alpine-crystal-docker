FROM alpine:3.10

RUN echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories \
    && apk add --no-cache --force-overwrite \
        build-base \
        crystal@edge~=0.31 \
        g++ \
        gc-dev \
        libevent-dev \
        libevent-static \
        libxml2-dev \
        llvm8 \
        llvm8-dev \
        llvm8-libs \
        llvm8-static \
        make \
        musl \
        musl-dev \
        musl-utils \       
        openssl-dev \
        pcre-dev \
        readline-dev \
        shards \
        yaml-dev \
        zlib-dev