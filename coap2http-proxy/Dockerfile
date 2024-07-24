FROM ubuntu:latest

# proxy path
ARG PROXYDIR="/home/coap2http-proxy"
ENV CERTS_PATH="${PROXYDIR}/certs"

# get all software packages required
RUN apt update && apt upgrade -y && \
    apt install -y git gcc g++ cmake libjsoncpp-dev uuid-dev zlib1g-dev openssl libssl-dev

WORKDIR ${PROXYDIR}

# copy all files
COPY . ${PROXYDIR}

# Verify the copy of files
RUN ls -la ${PROXYDIR} && ls -la ${PROXYDIR}/coap2http-proxy

# Set execute permissions on the scripts
RUN chmod +x ${PROXYDIR}/coap2http-proxy/install_*.sh

# Run the scripts
RUN ${PROXYDIR}/coap2http-proxy/install_liboqs_for_wolfssl.sh && \
    ${PROXYDIR}/coap2http-proxy/install_wolfssl.sh && \
    ${PROXYDIR}/coap2http-proxy/install_libcoap.sh && \
    cd ${PROXYDIR}/coap2http-proxy && ./install_proxy.sh

WORKDIR ${PROXYDIR}/coap2http-proxy