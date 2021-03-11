FROM wordpress:php8.0-fpm-alpine

# update the installation
RUN apk update 

#RUN apk add software-properties-common
RUN apk add php8-mbstring php8-curl php8-xml
RUN apk add iproute2

# install supervisord
#RUN apt-get -y install supervisor

# add user
#RUN groupadd webuser && usermod -a -G webuser www-data

EXPOSE 80
CMD /bin/ash