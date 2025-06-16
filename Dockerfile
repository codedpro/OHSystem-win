# syntax=docker/dockerfile:1

#############################
# Stage 1: Cross-compile on Linux container
#############################
FROM --platform=linux/amd64 dockcross/windows-static-x86 AS build

WORKDIR /src

# Copy source
COPY . .

# Install Boost and remove extra dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    wget libboost-all-dev \
    && rm -rf /var/lib/apt/lists/*

# Patch out MySQL and GMP flags
RUN sed -i 's/^DFLAGS = -DGHOST_MYSQL/DFLAGS =/' ghost++/ghost/Makefile \
    && sed -i 's/-lmysqlclient_r //' ghost++/ghost/Makefile \
    && sed -i 's/-lgmp//' ghost++/bncsutil/src/bncsutil/Makefile

# Build bncsutil using cross-compiler directly
RUN cd ghost++/bncsutil/src/bncsutil \
    && make CC=x86_64-w64-mingw32-gcc \
    CXX=x86_64-w64-mingw32-g++

# Build the GHost++ bot itself
RUN cd ghost++/ghost \
    && make CC=x86_64-w64-mingw32-gcc \
    CXX=x86_64-w64-mingw32-g++

#############################
# Stage 2: Export only the .exe
#############################
FROM scratch AS export
COPY --from=build /src/ghost++/ghost/ghost++.exe /ghost.exe
