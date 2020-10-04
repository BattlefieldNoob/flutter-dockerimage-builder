FROM ubuntu:focal

USER root

ARG flutter_version

ENV FLUTTER_HOME=/sdks/flutter

RUN echo "version $flutter_version"

ENV FLUTTER_VERSION=$flutter_version

RUN echo "version ${FLUTTER_VERSION}"

ENV FLUTTER_VERSION=1.22.0

ENV FLUTTER_ROOT=$FLUTTER_HOME

ENV PATH ${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin

RUN apt update && apt -y install git curl

RUN git clone --branch ${FLUTTER_VERSION} https://github.com/flutter/flutter.git ${FLUTTER_HOME}

RUN flutter config --enable-web

RUN yes | flutter doctor \
    && chown -R root:root ${FLUTTER_HOME}
