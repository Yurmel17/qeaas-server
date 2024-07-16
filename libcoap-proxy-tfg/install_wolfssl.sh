#!/bin/bash

install_mode="default"
# Installing missing packages for Raspberry Pi:
 apt-get update
 apt-get install -y autoconf automake libtool coreutils bsdmainutils

git clone https://github.com/wolfSSL/wolfssl.git
cd wolfssl
./autogen.sh

mkdir build
cd build

if [ "$install_mode" == "default" ]; then
    ../configure --enable-all  \
        --enable-dtls  \
        --enable-dtls13  \
        --enable-experimental \
        --enable-dtls-frag-ch \
        --with-liboqs \
        --disable-rpk # Important to disable this to work with certificates
else
    # after this fix https://github.com/obgm/libcoap/pull/1407
    # thiss build also works
    ../configure CFLAGS="-DHAVE_SECRET_CALLBACK" \
        --enable-opensslall \
        --enable-opensslextra \
        --enable-static \
        --enable-psk \
        --enable-alpn \
        --enable-aesccm \
        --enable-aesgcm \
        --enable-dtls-mtu \
        --enable-context-extra-user-data=yes \
        --enable-dtls \
        --enable-debug \
        --enable-dtls13 \
        --enable-tls13 \
        --enable-experimental \
        --with-liboqs \
        --enable-dtls-frag-ch
fi

make all
 make install