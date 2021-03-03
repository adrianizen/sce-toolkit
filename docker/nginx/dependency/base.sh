#!/bin/bash

apt-get install -y wget git && \
./pcre.sh && \
./zlib.sh && \
./openssl.sh && \
./vts.sh && \
./nginx.sh