FROM nvidia/cuda:11.6.2-base-ubuntu20.04
LABEL maintainer="sohn"

RUN apt update
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
RUN apt install -y git \
  clang-10 libc++-10-dev libc++abi-10-dev cmake ninja-build \
  libpng-dev libjpeg-dev \
  libpython3-dev python3-distutils \
  python3-pytest python3-pytest-xdist python3-numpy \
  python-is-python3 pip vim \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENV CC=clang-10
ENV CXX=clang++-10

RUN git clone --recursive https://github.com/mitsuba-renderer/mitsuba3 /mitsuba3

WORKDIR /mitsuba3
RUN mkdir build
ADD mitsuba.conf build/mitsuba.conf 
RUN cd build && cmake -GNinja .. && ninja

ENV PYTHONPATH="/mitsuba3/build/python:$PYTHONPATH"
ENV PATH="/mitsuba3/build:$PATH"