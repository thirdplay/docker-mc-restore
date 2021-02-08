FROM docker

RUN apk -U --no-cache add \
    bash \
    coreutils \
    openssh-client

COPY ./restore.sh /opt
RUN chmod +x /opt/restore.sh

VOLUME ["/data", "/backups"]

ENV HOME=/data

ENTRYPOINT ["/opt/restore.sh"]

