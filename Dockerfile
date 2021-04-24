ARG flutter_version=latest

FROM cirrusci/flutter:${flutter_version}

USER root

RUN echo "version $flutter_version"

RUN apt update \
    && apt -y install npm

#install npx for firebase deploy
RUN npm install -g npx

#clean up
RUN rm -rf /tmp/* /var/tmp/*
