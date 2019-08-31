FROM alpine:3.9

RUN apk add --update --no-cache --force-overwrite \
        crystal~=0.27 \
        g++ \
        gc-dev \
        libevent-dev \
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