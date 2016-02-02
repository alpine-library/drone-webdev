FROM alpinelib/base:edge
MAINTAINER Ekozan

ENV WEBDEV_VERSION 1.1

RUN apk-install bash ca-certificates go nodejs git docker make curl

RUN npm install grunt -g
RUN npm install bower -g
