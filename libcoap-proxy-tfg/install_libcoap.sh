#!/bin/bash

build_dir="$(pwd)/libcoap/build"
install_mode="default"
dtls_backend="wolfssl"

# Parse input parameters
while getopts "b:" opt; do
    case ${opt} in
        b )
            dtls_backend=$OPTARG
            ;;
        \? )
            echo "Usage: cmd [-b backend]"
            exit 1
            ;;
    esac
done

git clone https://github.com/obgm/libcoap
cd libcoap

if [ "$install_mode" == "default" ]; then
    echo "Using cmake...."
    mkdir -p $build_dir
    cd $build_dir
    CFLAGS="-DCOAP_WOLFSSL_GROUPS=\"\\\"P-384:P-256:KYBER_LEVEL1\\\"\"" cmake -DENABLE_DTLS=ON -DDTLS_BACKEND=${dtls_backend} -DENABLE_DOCS=OFF ..
else
    echo "Using autogen.sh...."
    ./autogen.sh
    ./configure --enable-dtls --with-${dtls_backend} --disable-manpages --disable-doxygen --enable-tests -prefix=$build_dir
    #./configure --enable-dtls --with-${dtls_backend} --disable-manpages --disable-doxygen --enable-tests -prefix=$build_dir
fi

# Build and install
make
make install

echo "---------------------------------"
echo "If sucessful, libcoap should be installed in /usr/local/lib"
echo "---------------------------------"