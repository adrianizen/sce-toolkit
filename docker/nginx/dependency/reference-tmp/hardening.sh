#!/bin/bash

# install openssl
apt-get install -y openssl

# Secure Diffie-Hellman for TLS
mkdir -p /opt/cert/ && \
cd /opt/cert/ && \
openssl dhparam -dsaparam -out dhparams.pem 4096
