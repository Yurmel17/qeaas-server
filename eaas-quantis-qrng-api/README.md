Welcome

# Quantum Entropy as a Service (QEaaS)

See [Entropy as a Service | NIST](https://csrc.nist.gov/csrc/media/projects/entropy-as-a-service/documents/pres_handout_final.pdf)

## C++ HTTP API

### Installing drogon

See [Drogon installation](https://drogonframework.github.io/drogon-docs/#/ENG-02-Installation).

First install the Linux dependencies specified in the link above.

Then run this on the roof of the project (or in the root of the API if we move it later)

```bash
git clone https://github.com/drogonframework/drogon
cd drogon
git submodule update --init
mkdir build
cd build
cmake ..
make && sudo make install
```

### Building the API

```bash
mkdir build
cd build
cmake ..
make
```

Run the project with

```bash
./eaas-quantis-qrng-api 
```

Test with:

```bash
curl -k http://127.0.0.1:6065/random_number/5
```