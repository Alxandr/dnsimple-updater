FROM $DOCKER_ARCH/alpine:3.9

LABEL maintainer="Aleksander Heintz <alxandr@alxandr.me>"

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint
ENTRYPOINT [ "docker-entrypoint" ]
CMD [ "update" ]
