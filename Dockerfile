#Dockerfile for SQLite bank API
#Version 1.0.0
ARG BUILDER_IMAGE="ubuntu:22.04"

FROM ${BUILDER_IMAGE} as builder

#Install build dependencies
RUN apt-get update && apt-get -y --no-install-recommends install
build-essential \

#Clang compiler
clang-15 \

#SQLite development headers and library
libsqlite3-dev \

#JSON parsing library
libcjson-dev \

#MicroHTTP library
libmicrohttpd-dev
&& apt-get clean
&& rm -rf /var/lib/apt/lists/*

#Specify include paths for SQLite, JSON and MicroHTTP
ENV C_INCLUDE_PATH="/usr/include/cjson:/usr/include/microhttpd:/usr/include/sqlite3"

WORKDIR /app

#Copy main application source
COPY main.c .

#Build with SQLite instead of PostgreSQL
RUN clang-15 -O2 -o main main.c -lsqlite3 -lcjson -lmicrohttpd

#Docker instruction for running container
CMD ["/app/main"]

#dockerfile authored by: zeh & tutoC
#date: 10-03-2024
#version: 1.0.1