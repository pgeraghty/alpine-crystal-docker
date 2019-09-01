FROM alpine:edge

RUN apk add --update --no-cache --force-overwrite \
        crystal \
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
        musl-dev \
        openssl-dev \
        pcre-dev \
        readline-dev \
        shards \
        yaml-dev \
        zlib-dev