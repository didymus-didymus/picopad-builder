# based on LTS ubuntu 22.04
FROM ubuntu:22.04

LABEL maintainer="didymus@tuta.io"
LABEL version="1.0"
LABEL description="Image for compiling PicoPad binaries"

ENV DEBIAN_FRONTEND=noninteractive

# Setup timezone
ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV PICO_SDK_PATH=/home/picoPad/pico-sdk/
ENV PICOPAD_BASE_PATH=/home/picoPad/picopad-playground/picopad-sdk/picopad-base/

# install packages
RUN apt-get update \
    && apt-get install -y git wget gcc-arm-none-eabi libnewlib-arm-none-eabi build-essential libstdc++-arm-none-eabi-newlib xxd python3\
    && apt-get install -y vim mc \
# Delete not needed folders and package
    && apt-get remove -y cmake \
    && rm -rf /var/lib/apt/lists/*

# build fresh cmake
RUN mkdir -p /home/picoPad/temp/ \
    && cd /home/picoPad/temp \
    && mkdir /opt/cmake \
    && wget https://github.com/Kitware/CMake/releases/download/v3.27.1/cmake-3.27.1-linux-x86_64.sh \
    && sh cmake-3.27.1-linux-x86_64.sh --skip-license --prefix=/opt/cmake \
    && ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake \
    && rm -rf /home/picoPad/temp/*

# Get SDK sources
RUN cd /home/picoPad/ \
    && git clone https://github.com/raspberrypi/pico-sdk.git --branch master \
    && git clone https://github.com/didymus-didymus/picopad-builder-tools.git --branch main \
    && cd /home/picoPad/pico-sdk/ \
    && git submodule update --init \
    && cd .. \
    && git clone https://github.com/raspberrypi/pico-examples.git --branch master \
    && git clone https://github.com/tvecera/picopad-playground.git --branch main \
    && cd /home/picoPad/picopad-playground/ \
# workarounds    
    && sed -i s,git@github.com:,https://github.com/,g .gitmodules \
    && git submodule update --init \
    && cd /home/picoPad/picopad-playground/picopad-sdk/picopad-gb/ \
    && sed -i s,set\(PICO,set\(X-PICO,g CMakeLists.txt \
    && mkdir -p /home/picoPad/picopad-playground/picopad-sdk/assets/ \
# building MakeFile
    && cmake .

WORKDIR /home/picoPad/picopad-playground/picopad-sdk/picopad-gb/