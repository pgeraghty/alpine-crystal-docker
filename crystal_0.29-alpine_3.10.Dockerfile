FROM alpine:3.10

RUN apk add --update --no-cache --force-overwrite \
        crystal~=0.29 \
        g++ \
        gc-dev \
        libevent-dev \
        libevent-static \
        libxml2-dev \
        llvm5 \
        llvm5-dev \
        llvm5-libs \
        llvm5-static \
        make \
        musl-dev \
        openssl-dev \
        pcre-dev \
        readline-dev \
        shards \
        yaml-dev \
        zlib-dev