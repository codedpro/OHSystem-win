# syntax=docker/dockerfile:1

#############################
# Stage 1: Cross‐compile on Linux container
#############################
FROM --platform=linux/amd64 dockcross/windows-static-x86 AS build
WORKDIR /src

# 1) Copy source
COPY . .

# 2) Install Boost & unzip
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    wget unzip libboost-all-dev \
    && rm -rf /var/lib/apt/lists/*

# 3) Download the Windows Connector/C ZIP (x64) and unpack it,
#    then rename the extracted folder to a stable path
RUN wget -O mysql-connector.zip \
    https://downloads.mysql.com/archives/get/p/19/file/mysql-connector-c-6.1.11-winx64.zip \
    && unzip mysql-connector.zip \
    && rm mysql-connector.zip \
    && mv mysql-connector-c-6.1.11-winx64 mysql-connector

# 4) Expose where the connector lives
ENV MYSQL_INC=/src/mysql-connector/include
ENV MYSQL_LIB=/src/mysql-connector/lib

# 5) Strip only GMP (keep MySQL)
RUN sed -i 's/-lgmp//' ghost++/bncsutil/src/bncsutil/Makefile

# 6) Build bncsutil using the MinGW cross‐compiler
RUN cd ghost++/bncsutil/src/bncsutil \
    && make CC=x86_64-w64-mingw32-gcc \
    CXX=x86_64-w64-mingw32-g++

# 7) Build GHost++ with Boost & MySQL support
RUN cd ghost++/ghost \
    && make \
    CC=x86_64-w64-mingw32-gcc \
    CXX=x86_64-w64-mingw32-g++ \
    CXXFLAGS="-I../bncsutil/src -I../StormLib -I${MYSQL_INC}" \
    LDFLAGS="-L../bncsutil/src -L${MYSQL_LIB} -lmysql"

#############################
# Stage 2: Export only the .exe
#############################
FROM scratch AS export
COPY --from=build /src/ghost++/ghost/ghost++.exe /ghost.exe
