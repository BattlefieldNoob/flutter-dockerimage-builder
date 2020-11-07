FROM ubuntu:focal

USER root

ARG flutter_version

ENV FLUTTER_HOME=/sdks/flutter

RUN echo "version $flutter_version"

ENV FLUTTER_VERSION=$flutter_version

ENV FLUTTER_ROOT=$FLUTTER_HOME

ENV PATH ${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin

RUN apt update \
    && apt -y install git curl unzip rsync xz-utils \
    && apt clean autoclean \
    && apt autoremove --yes \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/lib/log/* \
    && rm -rf /var/lib/cache/* \
    && rm -rf /var/lib/dpkg/* \
    && rm -rf /var/lib/apt/* 


RUN git clone --branch ${FLUTTER_VERSION} https://github.com/flutter/flutter.git ${FLUTTER_HOME}

RUN yes | flutter doctor \
    && chown -R root:root ${FLUTTER_HOME}

RUN flutter config --enable-web

#clean up
RUN rm -rf /tmp/* /var/tmp/*