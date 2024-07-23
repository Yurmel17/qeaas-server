FROM ubuntu:latest

# api path
ARG APIDIR="/home/eaas-quantis-qrng-api"

# api run
ARG APIRUN=${APIDIR}/build

# get all software packages required
RUN apt update && apt upgrade -y && apt install -y \
    && apt install git -y && apt install gcc -y && apt install g++ -y && apt install cmake -y \
    && apt install libjsoncpp-dev -y && apt install uuid-dev -y && apt install zlib1g-dev -y \
    && apt install openssl -y && apt install libssl-dev -y

WORKDIR ${APIDIR}

    COPY . ${APIDIR}
    RUN git clone https://github.com/drogonframework/drogon && cd drogon \
        && git submodule update --init && mkdir build && cd build && cmake .. \
        && make && make install

WORKDIR ${APIDIR}

    RUN mkdir build && cd build && cmake .. && make

WORKDIR ${APIRUN}