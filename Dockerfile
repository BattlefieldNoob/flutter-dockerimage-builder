ARG flutter_version=2.2.3

ARG gitImage="frolvlad/alpine-glibc:latest"
ARG baseImage="frolvlad/alpine-glibc:latest"

FROM $gitImage AS flutterCloneImage

ARG flutter_version

RUN mkdir /sdks
WORKDIR /sdks

RUN apk add --no-cache bash git curl

RUN git clone --depth 1 --branch $flutter_version https://github.com/flutter/flutter.git

ENV FLUTTER_HOME /sdks/flutter/bin


RUN ${FLUTTER_HOME}/flutter doctor \
    && ${FLUTTER_HOME}/flutter create /project 

WORKDIR /project

RUN ${FLUTTER_HOME}/flutter build web \
    && rm -r ${FLUTTER_HOME}/cache/flutter_web_sdk/flutter_web_sdk 

FROM $baseImage

ARG flutter_version

COPY --from=flutterCloneImage /sdks /sdks

COPY --from=flutterCloneImage /root /root

COPY --from=flutterCloneImage /usr/bin /usr/bin
COPY --from=flutterCloneImage /usr/lib /usr/lib
COPY --from=flutterCloneImage /usr/libexec /usr/libexec
COPY --from=flutterCloneImage /bin/bash /bin/bash


ENV FLUTTER_HOME=/sdks/flutter \
    FLUTTER_VERSION=$flutter_version
ENV FLUTTER_ROOT=$FLUTTER_HOME

ENV PATH ${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin

#needed for curl 
RUN apk add --no-cache ca-certificates
