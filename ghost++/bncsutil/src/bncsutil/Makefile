SHELL = /bin/sh
SYSTEM = $(shell uname)
CXX = g++
CXXFLAGS = -Wall -O3 -I ../ -Wno-multichar -fPIC -DMUTIL_LIB_BUILD
CXXOBJ = bsha1.o cdkeydecoder.o checkrevision.o decodekey.o file.o libinfo.o oldauth.o
CC = gcc
CCFLAGS = -Wall -O3 -I ../ -Wno-multichar -fPIC -DMUTIL_LIB_BUILD
CCOBJ = nls.o pe.o sha1.o stack.o

TARGET = libbncsutil.so
OBJS = $(CXXOBJ) $(CCOBJ)

$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -shared $(OBJS) -o libbncsutil.so

$(CXXOBJ): %.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@ 

$(CCOBJ): %.o: %.c
	$(CC) $(CCFLAGS) -c $< -o $@

clean:
	rm -f $(CCOBJ) $(CXXOBJ) $(TARGET) *~
all:
	make $(TARGET)

install: $(TARGET)
	mkdir -p /usr/include/bncsutil
	cp *.h /usr/include/bncsutil
	cp $(TARGET) /usr/lib
	ldconfig
