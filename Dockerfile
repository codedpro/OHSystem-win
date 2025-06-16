FROM dockcross/windows-static-x86

WORKDIR /usr/src/app
COPY . .

# disable MySQL to avoid extra dependencies
RUN sed -i 's/^DFLAGS = -DGHOST_MYSQL/DFLAGS =/' ghost++/ghost/Makefile && \
    sed -i 's/-lmysqlclient_r //' ghost++/ghost/Makefile

# build bncsutil library
RUN /usr/local/bin/dockcross bash -c "cd ghost++/bncsutil/src/bncsutil && make"

# build ghost executable
RUN /usr/local/bin/dockcross bash -c "cd ghost++/ghost && make C++=\$CXX CC=\$CC"

# copy final binary to /dist for easy volume mount
RUN mkdir /dist && cp ghost++/ghost/ghost++.exe /dist/ghost.exe

CMD ["/bin/bash"]
