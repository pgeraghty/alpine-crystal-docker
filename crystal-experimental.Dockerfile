FROM alpine:edge as builder

RUN apk add --update --no-cache --force-overwrite \
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
        tzdata \
        yaml-dev \
        zlib-dev && \
    apk -U add alpine-sdk

RUN adduser -D packager && addgroup packager abuild


USER packager
WORKDIR /home/packager

RUN abuild-keygen -a -n

RUN mkdir build_crystal && cd build_crystal && \
    wget -O APKBUILD https://git.alpinelinux.org/aports/plain/community/crystal/APKBUILD?id=284dccd1b95258f680a1aa3f9744f69646e033d1 && \
    wget -O disable-specs-using-GB2312-encoding.patch https://git.alpinelinux.org/aports/plain/community/crystal/disable-specs-using-GB2312-encoding.patch?id=284dccd1b95258f680a1aa3f9744f69646e033d1 && \
    wget -O fix-spec-std-kernel-spec.cr.patch https://git.alpinelinux.org/aports/plain/community/crystal/fix-spec-std-kernel-spec.cr.patch?id=284dccd1b95258f680a1aa3f9744f69646e033d1 && \    
    abuild -r


USER root
RUN apk add --allow-untrusted packages/packager/x86_64/crystal-0.30.1-r1.apk

USER packager

RUN rm packages/packager/x86_64/APKINDEX.tar.gz

COPY --chown=packager ./shards-0.8.1-r1 /home/packager/shards
WORKDIR /home/packager/shards
RUN abuild -r


FROM alpine:3.10
WORKDIR /

COPY --from=builder /home/packager/packages/packager/x86_64/crystal-0.30.1-r1.apk /tmp
COPY --from=builder /home/packager/packages/packager/x86_64/shards-0.8.1-r1.apk /tmp

RUN apk add --update --no-cache --force-overwrite \
        git \
        g++ \
        gc-dev \
        gcc \
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
        musl-dev \ 
        openssl-dev \
        pcre-dev \
        readline-dev \
        tzdata \
        yaml-dev \
        zlib-dev

RUN apk add --allow-untrusted /tmp/*.apk && rm /tmp/*.apk