FROM wordpress:php8.0-fpm-alpine

# update the installation
RUN apk update 

RUN apk add php8-mbstring php8-curl php8-xml php8-fpm php8-cgi
RUN apk add iproute2 net-tools openrc

# Somehow it should be added to view service status[https://github.com/gliderlabs/docker-alpine/issues/437]
VOLUME /sys/fs/cgroup
RUN mkdir -p /run/openrc \
    && touch /run/openrc/softlevel

RUN mkdir -p /build/
WORKDIR /build/
COPY ./dependency/ /build/

# install supervisord
#RUN apt-get -y install supervisor

RUN ./install_nginx.sh

EXPOSE 80
ENTRYPOINT ["/script/start.sh"]