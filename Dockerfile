ARG flutter_version=latest

FROM cirrusci/flutter:${flutter_version}

USER root

RUN echo "version ${flutter_version}"

RUN apt update \
    && apt -y install npm \
    && apt clean autoclean \
    && apt autoremove --yes \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/lib/log/* \
    && rm -rf /var/lib/cache/* \
    && rm -rf /var/lib/dpkg/* \
    && rm -rf /var/lib/apt/*

#install npx for firebase deploy
RUN npm install -g npx

#clean up
RUN rm -rf /tmp/* /var/tmp/*
