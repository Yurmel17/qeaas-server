FROM ubuntu:latest

# proxy path
ARG PROXYDIR="/home/libcoap-proxy-tfg"
ENV CERTS_PATH="${PROXYDIR}/certs"

# get all software packages required
RUN apt update && apt upgrade -y && apt install -y \
    && apt install git -y && apt install gcc -y && apt install g++ -y && apt install cmake -y \
    && apt install libjsoncpp-dev -y && apt install uuid-dev -y && apt install zlib1g-dev -y \
    && apt install openssl -y && apt install libssl-dev -y

WORKDIR ${PROXYDIR}

# copy all files
COPY . ${PROXYDIR}

# Verificar la copia de archivos
RUN ls -la ${PROXYDIR} #&& ls -la ${PROXYDIR}/src

# Set execute permissions on the scripts
RUN chmod +x ${PROXYDIR}/install_*.sh

# Run the scripts
RUN ${PROXYDIR}/install_liboqs_for_wolfssl.sh && \
    ${PROXYDIR}/install_wolfssl.sh && \
    ${PROXYDIR}/install_libcoap.sh && \
    ${PROXYDIR}/install_proxy.sh

WORKDIR ${PROXYDIR}