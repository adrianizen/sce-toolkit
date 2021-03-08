FROM ubuntu:20.04

# update the installation
RUN apt-get -y update 

# add ubuntu tools
RUN apt-get install -y iproute2 tzdata

RUN mkdir -p /build/
WORKDIR /build/
COPY ./dependency/ /build/
RUN ./base.sh

RUN apt-get install -y rsyslog
RUN apt-get install -y logrotate

WORKDIR /

EXPOSE 80
EXPOSE 443
CMD ["/bin/bash"]
# CMD ./script/start.sh && /bin/bash
