FROM alpinelib/base:edge
MAINTAINER Ekozan

ENV WEBDEV_VERSION 1.0

RUN apk-install bash ca-certificates go nodejs git docker

RUN npm install grunt -g
RUN npm install bower -g

VOLUME /var/lib/mysql

COPY docker-entrypoint.sh /
COPY files /

ENTRYPOINT ["sh"]

RUN chmod +x /docker-entrypoint.sh


EXPOSE 3306
CMD ["mysqld"]
