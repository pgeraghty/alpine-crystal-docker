FROM alpine:edge

RUN apk add --update --no-cache --force-overwrite \
        crystal \
        g++ \
        gc-dev \
        git \
        gmp-dev \
        libatomic_ops \
        libevent-dev \
        libevent-static \
        libxml2-dev \
        llvm5 \
        llvm5-dev \
        llvm5-libs \
        llvm5-static \      
        make \
        musl \
        musl-dev \
        musl-utils \ 
        openssl-dev \
        pcre-dev \
        readline-dev \
        shards \
        tzdata \
        yaml-dev \
        zlib-dev && \
    apk -U add alpine-sdk

RUN apk update     
        llvm8 \
        llvm8-dev \
        llvm8-libs \
        llvm8-static && \
    apk del crystal shards && \
    adduser -D packager && addgroup packager abuild


USER packager
WORKDIR /home/packager

RUN abuild-keygen -a -n

RUN mkdir crystal && cd crystal && \
    wget -O APKBUILD https://git.alpinelinux.org/aports/plain/community/crystal/APKBUILD && \
    wget -O disable-specs-using-GB2312-encoding.patch https://git.alpinelinux.org/aports/plain/community/crystal/disable-specs-using-GB2312-encoding.patch && \
    wget -O fix-spec-std-kernel-spec.cr.patch https://git.alpinelinux.org/aports/plain/community/crystal/fix-spec-std-kernel-spec.cr.patch && \    
    abuild clean deps unpack prepare build check