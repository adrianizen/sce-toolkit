
FROM alpine:3.13

RUN apk --update add redis

# COPY docker-entrypoint.sh /usr/local/bin/

EXPOSE 6379

ENTRYPOINT ["/script/start.sh"]


# CMD ["redis-server"]