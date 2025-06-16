# syntax=docker/dockerfile:1

# Stage 1: Build with cross-compiler
FROM --platform=linux/amd64 dockcross/windows-static-x86 AS build
WORKDIR /src

# Copy source
COPY . .

# Disable MySQL to avoid extra dependencies
RUN sed -i 's/^DFLAGS = -DGHOST_MYSQL/DFLAGS =/' ghost++/ghost/Makefile && \
    sed -i 's/-lmysqlclient_r //' ghost++/ghost/Makefile

# Generate and use dockcross wrapper on host instead of in-container
# (Ensure you've run: docker run --rm dockcross/windows-static-x86 > dockcross && chmod +x dockcross)
COPY ./dockcross-windows-static-x86 /usr/local/bin/dockcross

# Build libraries and executable
RUN /usr/local/bin/dockcross bash -c \
    "cd ghost++/bncsutil/src/bncsutil && make && \
    cd ../../../../ghost && make"

# Stage 2: Package only the .exe
FROM scratch AS export
COPY --from=build /src/ghost++/ghost/ghost++.exe /ghost.exe
