FROM wordpress:php8.0-fpm-alpine

# update the installation
RUN apt-get update 

RUN apt-get install software-properties-common -y
RUN apt-get install php8.0-mbstring php8.0-curl php8.0-xml -y
RUN apt-get install iproute2

# install supervisord
#RUN apt-get -y install supervisor

# add user
#RUN groupadd webuser && usermod -a -G webuser www-data

EXPOSE 80
CMD /bin/ash