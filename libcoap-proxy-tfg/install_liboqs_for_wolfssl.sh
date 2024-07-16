#!/bin/bash

# SEE: https://github.com/wolfSSL/wolfssl/blob/master/INSTALL

debug_mode=0

# Parse command-line options
while getopts "d" opt; do
  case $opt in
    d)
      debug_mode=1
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

# Dir for the current script
current_dir=$(pwd)
echo "Current dir: $current_dir"
liboqs_target_dir="/opt/liboqs"

# Prompt user for removal of existing installation
read -p "Do you want to remove existing installation? (y/n): " remove_existing
if [ "$remove_existing" == "y" ]; then
    echo "Removing existing installation..."
     rm -rf /usr/local/include/oqs
     rm -f /usr/local/lib/liboqs.a
     rm -rf ${liboqs_target_dir}
fi

echo "Cloning liboqs..."

 mkdir -p ${liboqs_target_dir}
cd ${liboqs_target_dir}                                                                                                                                                                                 
 git clone --single-branch https://github.com/open-quantum-safe/liboqs.git
cd liboqs/                                                                          
#git checkout afs76ca3b1f2fbc1f4f0967595f3bb07692fb3d82
 git checkout 0.8.0

if [ $debug_mode -eq 1 ]; then                                                                                                                                                                              
    # Copy the logging files
    echo "Copying the logging files"
     cp ${current_dir}/liboqs_logging/kem_kyber_512.c ${liboqs_target_dir}/liboqs/src/kem/kyber/kem_kyber_512.c
     cp ${current_dir}/liboqs_logging/kem_kyber_768.c ${liboqs_target_dir}/liboqs/src/kem/kyber/kem_kyber_768.c
     cp ${current_dir}/liboqs_logging/kem_kyber_1024.c ${liboqs_target_dir}/liboqs/src/kem/kyber/kem_kyber_1024.c
fi

##echo "Building liboqs..."
 mkdir build
cd build
 cmake -DOQS_USE_OPENSSL=0 ..
 make all
 make install