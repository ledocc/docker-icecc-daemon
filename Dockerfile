FROM alpine:3.12

ARG icecc_git_ref=1.3.1

RUN apk --no-cache add libcap-ng lzo libstdc++ zstd libarchive && \
    apk --no-cache add --virtual .bdeps alpine-sdk git automake autoconf libtool libcap-ng-dev lzo-dev zstd-dev libarchive-dev && \
    git clone https://github.com/icecc/icecream -b ${icecc_git_ref} && \
    (cd icecream && autoreconf -i && ./configure --without-man && make && make install) && \
    rm -rf icecream && \
    apk del .bdeps

RUN adduser -S icecc

COPY run-iceccd.sh /tmp/run-iceccd.sh
RUN chmod 755 /tmp/run-iceccd.sh

# Run icecc daemon in verbose mode
ENTRYPOINT ["/tmp/run-iceccd.sh"]

# iceccd port
EXPOSE 10245 8765/TCP 8765/UDP 8766
