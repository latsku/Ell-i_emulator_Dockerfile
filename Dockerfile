#
# Python Dockerfile
#
# https://github.com/dockerfile/python
#

# Pull base image.
FROM dockerfile/ubuntu

MAINTAINER Lari Lehtomäki <lari@lehtomaki.fi>


RUN dpkg --add-architecture i386
RUN apt-get update

## Install required libraries to build the ELL-i runtime in 32-bit environment.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y gcc libc6-dev-i386 lib32stdc++-4.8-dev

## Install 32-bit python & setuptools
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python:i386 python-setuptools
RUN easy_install -Z robotframework
RUN easy_install -Z docutils


RUN git clone https://github.com/Ell-i/ELL-i-PyBot-Tests.git /data/PyBot-Tests
ADD runtime_path.patch /data/
RUN patch --directory /data/PyBot-Tests/ < /data/runtime_path.patch

## We are using Asif's repository at the moment as the code is not integrator to the runtime master.
# RUN git clone https://github.com/Ell-i/Runtime.git /data/Runtime
RUN git clone https://github.com/asifsardar26/Runtime.git /data/Runtime

## Change branch as the emulator code is not integrated to the runtime master.
RUN git --git-dir /data/Runtime/.git --work-tree /data/Runtime checkout feature-runtime-temp

## Create an empty sketch file for compilation
RUN echo "void setup() {}" > /data/Runtime/stm32/build/sketch.cpp && echo "void loop() {}" >> /data/Runtime/stm32/build/sketch.cpp

## Build the libemulator.so
RUN make -C /data/Runtime/stm32/build PLATFORM=emulator all

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["bash"]
