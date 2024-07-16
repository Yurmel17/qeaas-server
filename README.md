# Quantum Entropy as a Service (QEaaS)

See [Entropy as a Service | NIST](https://csrc.nist.gov/csrc/media/projects/entropy-as-a-service/documents/pres_handout_final.pdf)

## C++ HTTP API

This is a fork of: https://gitlab.gast.it.uc3m.es/qursa/qeaas/eaas-quantis-qrng-api \
Included: https://gitlab.gast.it.uc3m.es/qursa/qeaas/libcoap-proxy-tfg and https://github.com/qursa-uc3m/quantis-qrng-tls-pq-bench, as submodules

After cloning, manually initialize and update the git submodules with the following command:
```bash
git submodule update --init --recursive
```

## Docker-compose to start all containers

First, run the script to set up the environment by updating submodules and copying necessary configuration files
```bash
./setup-and-clean.sh
```

Then, build the API service, the nginx reverse proxy, and the libcoap proxy
```bash
docker-compose up --build
```

Test the nginx reverse proxy with

```bash
docker run --network host --rm -it openquantumsafe/curl curl -k https://127.0.0.1:4433/random_number/5
docker run --network host --rm -it openquantumsafe/curl curl -k --curves kyber512 https://127.0.0.1:4433/random_number/5
```

Test the CoAP to HTTP proxy with
```bash
docker run --rm --network host my-coap2http-server ./libcoap/build/coap-client -P coaps://[::1]/ -m get http://127.0.0.1:6065/random_number/5
```

## Open Quantum Safe's dockerized nginx server

Check the [oqs-demos/nginx](https://github.com/open-quantum-safe/oqs-demos/tree/main/nginx) dockerized nginx server with liboqs provider.

We may want to use nginx as a reverse proxy for the API so we may want to use this image and just change the configuration `nginx.conf` file.

### With QRNG integration

We may want to use our own docker image of the nginx server with the Quantis QRNG integration in OpenSSL, see the `quantis-qrng-nginx` folder in the [qursa-uc3m/quantis-qrng-tls-pq-bench](https://github.com/qursa-uc3m/quantis-qrng-tls-pq-bench) repository. This way we can have all the HTTP stack secured with quantum random numbers and PQ cryptography.

## Apache (PQ enabled) HTTP reverse proxy

I have some documentation and installation scripts for running an Apache HTTP server with the liboqs provider as a reverse proxy, you can find it in the `apache-oqs-openssl-pq-integration` folder.

## Open Quantum Safe's liboqs OpenSSL provider

If you ever need to build a local OpenSSL installation for the liboqs provider, check the `README.md` in the `oqs-provider-and-openssl3` folder. You can find instructions there and automated installation scripts.

Although the most likely is that we end up using Dockerized versions.

## Server architecture

This is the idea. We don't show docker containers in the diagram but we will use them for the API, for the nginx server packed with OpenSSL, and for the CoAP proxy packed with wolfSSL:

![Alt text](images/drawio_server_architecture.jpg?raw=true "Server architecture")

