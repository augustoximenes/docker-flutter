FROM ubuntu:18.04

# Dependencies
ENV WORKSPACE=/opt

RUN apt-get update -y && \
    apt-get install -y apt-utils && \
    apt-get install -y git && \
    apt-get install -y curl && \
    apt-get install -y unzip

# Android SDK
ENV ANDROID_HOME=${WORKSPACE}/android-sdk \
    ANDROID_SDK_VERSION=4333796

RUN mkdir -p ${ANDROID_HOME} && cd ${ANDROID_HOME} && \
    curl https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip -o android-sdk-tools.zip && \ 
    unzip -q android-sdk-tools.zip -d ${ANDROID_HOME} && \ 
    rm android-sdk-tools.zip

# Flutter
ENV FLUTTER_HOME=${WORKSPACE}/flutter \
    FLUTTER_VERSION=v1.9.1+hotfix.6

ENV PATH ${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin

RUN mkdir -p ${FLUTTER_HOME} && \
    git clone https://github.com/flutter/flutter.git ${FLUTTER_HOME} && \
    flutter doctor