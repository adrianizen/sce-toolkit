FROM wordpress:php8.0-fpm-alpine

# update the installation
RUN apk update 

RUN docker-php-ext-install mysqli

RUN apk add php8-mysqli php8-mbstring php8-curl php8-xml php8-fpm php8-cgi \
    php8-dom php8-exif php8-fileinfo php8-json php8-openssl \
    php8-xml php8-zip php8-zlib \
    php8-ftp php8-gd


# Install server related petty module
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

RUN ./pre_start_php.sh
RUN ./pre_start_nginx.sh
RUN ./pre_start_imagick.sh

EXPOSE 80
ENTRYPOINT ["/script/start.sh"]