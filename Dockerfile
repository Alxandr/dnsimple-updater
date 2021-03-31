FROM alpine:3.13.4

LABEL maintainer="Aleksander Heintz <alxandr@alxandr.me>"

RUN apk add --no-cache curl
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint
ENTRYPOINT [ "docker-entrypoint" ]
CMD [ "update" ]
