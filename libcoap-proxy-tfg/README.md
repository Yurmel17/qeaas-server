# libcoap-proxy

This is a fork of [https://github.com/Rodriferli/libcoap-proxy-TFG](https://github.com/Rodriferli/libcoap-proxy-TFG).

## Install the project

First install libcoap

```bash
./install_libcoap.sh -b wolfssl
```

where `-b` is the backend to use. The options are `wolfssl` and `openssl`, the default is `wolfssl`.

This will install libcoap in the `/usr/local/lib` directory.

Then install the proxy

```bash
./install_proxy.sh </path/to/libcoap>
```

## Running the proxy

First ensure the HTTP server is running. Then run the proxy with the following command

```bash
 ./build/coap2HttpServer -P ",my_proxy"
```

And then run the coap client

```bash
./<path_to_coap_client>/coap-client -P coap://[::1] -m get http://127.0.0.1:6065/random_number/5
```

### With DTLS

Ensure you have the certificates in the `certs` directory. Then run the proxy with the following command

```bash
certs_path="./certs"
./build/coap2HttpServer -A ::1 -c ${certs_path}/server_cert.pem -j ${certs_path}/server_key.pem -P ",my_proxy"
```

And then run the coap client

```bash
./libcoap/build/coap-client -P coaps://[::1]/ -m get http://127.0.0.1:6065/random_number/5
```


### With Docker

Build the project Docker image

```bash
docker build -t my-coap2http-server .
```

Docker command to run the proxy

```bash
docker run -it --rm --network host  my-coap2http-server
./build/coap2HttpServer -A ::1 -c ${CERTS_PATH}/server_cert.pem -j ${CERTS_PATH}/server_key.pem -P ",my_proxy"
```

Docker command for the client

```bash
docker run --rm --network host  my-coap2http-server ./libcoap/build/coap-client -P coaps://[::1]/ -m get http://127.0.0.1:6065/random_number/5
```
