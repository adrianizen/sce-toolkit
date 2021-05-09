
FROM alpine:3.13

RUN apk update

# Install server related petty module
RUN apk add curl iproute2 net-tools openrc

# Somehow it should be added to view service status[https://github.com/gliderlabs/docker-alpine/issues/437]
VOLUME /sys/fs/cgroup
RUN mkdir -p /run/openrc \
    && touch /run/openrc/softlevel

RUN apk add redis
# RUN rc-status --servicelist
# COPY docker-entrypoint.sh /usr/local/bin/

EXPOSE 6379

ENTRYPOINT ["/script/start.sh"]


# CMD ["redis-server"]