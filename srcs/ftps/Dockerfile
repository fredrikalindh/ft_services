FROM alpine

ENV PUREFTPD_VERSION=1.0.49-r0 \
    SYSLOG_STDOUT_VERSION=1.1.1

RUN printf '%s\n' \
    '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' \
    >> /etc/apk/repositories \
	&& apk update \
    && apk add pure-ftpd@testing="${PUREFTPD_VERSION}"

COPY pure-ftpd.pem /etc/ssl/private/
COPY start.sh .
EXPOSE 80 30001
ENTRYPOINT sh /start.sh