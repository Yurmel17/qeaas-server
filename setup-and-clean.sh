#!/bin/bash

# Update git submodules
git submodule update --init --recursive

# Copy the nginx config file inside the quantis integration submodule
cp ./nginx_reverse_proxy/nginx-conf/nginx.conf ./nginx_reverse_proxy/quantis-qrng-tls-pq-bench/quantis-qrng-nginx/nginx-conf/nginx.conf

# Stop and remove Docker containers if they exist
docker stop my-coap2http-server > /dev/null 2>&1
docker rm my-coap2http-server > /dev/null 2>&1

docker stop oqs-nginx > /dev/null 2>&1
docker rm oqs-nginx > /dev/null 2>&1

docker stop qrng-api > /dev/null 2>&1
docker rm qrng-api > /dev/null 2>&1
