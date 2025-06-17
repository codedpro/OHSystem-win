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
    mingw-w64-tools binutils-mingw-w64-i686 \
    gcc-mingw-w64-i686 g++-mingw-w64-i686 \
    && rm -rf /var/lib/apt/lists/*

# 3) Download the Windows Connector/C ZIP (32-bit) and unpack it,
#    then rename the extracted folder to a stable path. Using the
#    32-bit version matches the dockcross base image which targets
#    a 32-bit Windows toolchain.
RUN wget -O mysql-connector.zip \
    https://downloads.mysql.com/archives/get/p/19/file/mysql-connector-c-6.1.11-win32.zip \
    && unzip mysql-connector.zip \
    && rm mysql-connector.zip \
    && mv mysql-connector-c-6.1.11-win32 mysql-connector \
    && gendef mysql-connector/lib/libmysql.dll \
    && mv libmysql.def mysql-connector/lib/libmysql.def \
    && i686-w64-mingw32-dlltool -d mysql-connector/lib/libmysql.def \
       -l mysql-connector/lib/libmysql.a -D mysql-connector/lib/libmysql.dll

# 4) Expose where the connector lives
ENV MYSQL_INC=/src/mysql-connector/include
ENV MYSQL_LIB=/src/mysql-connector/lib

# 5) Strip only GMP (keep MySQL)
RUN sed -i 's/-lgmp//' ghost++/bncsutil/src/bncsutil/Makefile

# 6) Build bncsutil using the MinGW cross‐compiler
RUN cd ghost++/bncsutil/src/bncsutil \
    && make CC=i686-w64-mingw32-gcc \
    CXX=i686-w64-mingw32-g++

# 7) Build GHost++ with Boost & MySQL support
RUN cd ghost++/ghost \
    && make \
    CC=i686-w64-mingw32-gcc \
    CXX=i686-w64-mingw32-g++ \
    CFLAGS="-I../bncsutil/src -I../StormLib -I${MYSQL_INC}" \
    LFLAGS="-L../bncsutil/src -L${MYSQL_LIB} -lmysql"

#############################
# Stage 2: Export only the .exe
#############################
FROM scratch AS export
COPY --from=build /src/ghost++/ghost/ghost++.exe /ghost.exe
