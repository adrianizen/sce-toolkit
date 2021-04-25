FROM wordpress:php8.0-fpm-alpine

# update the installation
RUN apk update 

# Install server related petty module
RUN apk add curl iproute2 net-tools openrc

# Somehow it should be added to view service status[https://github.com/gliderlabs/docker-alpine/issues/437]
VOLUME /sys/fs/cgroup
RUN mkdir -p /run/openrc \
    && touch /run/openrc/softlevel

RUN mkdir -p /build/
WORKDIR /build/
COPY ./dependency/ /build/

# install supervisord
#RUN apt-get -y install supervisor

RUN ./pre_start_php.sh
RUN ./pre_start_nginx.sh
RUN ./pre_start_node.sh
RUN ./pre_start_supervisor.sh

EXPOSE 80
ENTRYPOINT ["/script/start.sh"]