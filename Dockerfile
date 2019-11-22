# Base
FROM ubuntu:18.04

# Author
LABEL maintainer "augustoximenes@gmail.com"

# Dependencies
ENV WORKSPACE=/opt
ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update -y && \
    apt-get install -y dialog && \
    apt-get install -y apt-utils && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y git && \
    apt-get install -y curl && \
    apt-get install -y wget && \
    apt-get install -y unzip

# Android SDK
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
    ANDROID_HOME=${WORKSPACE}/android-sdk \
    ANDROID_SDK_VERSION=4333796 \
    ANDROID_PLATFORM_VERSION=29 \
    ANDROID_BUILD_TOOLS_VERSION=29.0.2

RUN mkdir -p ${ANDROID_HOME} && cd ${ANDROID_HOME} && \
    wget -q https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip && \ 
    unzip *tools*linux*.zip && \ 
    rm *tools*linux*.zip 

ENV PATH ${PATH}:${ANDROID_HOME}/emulator:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools/bin

RUN yes | sdkmanager --licenses && \
    touch /root/.android/repositories.cfg && \
    sdkmanager tools && \
    sdkmanager platform-tools && \
    sdkmanager emulator

RUN yes | sdkmanager "platforms;android-$ANDROID_PLATFORM_VERSION" "build-tools;$ANDROID_BUILD_TOOLS_VERSION"

# Flutter
ENV FLUTTER_HOME=${WORKSPACE}/flutter \
    FLUTTER_VERSION=v1.9.1+hotfix.6

ENV PATH ${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin

RUN mkdir -p ${FLUTTER_HOME} && \
    git clone https://github.com/flutter/flutter.git ${FLUTTER_HOME} && \
    flutter doctor