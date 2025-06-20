SHELL = /bin/sh
SYSTEM = $(shell uname)
CXX ?= g++
CC = gcc
DFLAGS = -DGHOST_MYSQL
OFLAGS = -O3 -g
LFLAGS = -L. -L../bncsutil/src/bncsutil/ -L../StormLib/stormlib/  -lbncsutil -lpthread -ldl -lz -lgmp -lStorm -lmysqlclient_r -lboost_date_time -lboost_thread -lboost_system -lboost_filesystem
CFLAGS =

ifeq ($(SYSTEM),Darwin)
DFLAGS += -D__APPLE__
OFLAGS += -flat_namespace
else
LFLAGS += -lrt
endif

ifeq ($(SYSTEM),FreeBSD)
DFLAGS += -D__FREEBSD__
endif

ifeq ($(SYSTEM),SunOS)
DFLAGS += -D__SOLARIS__
LFLAGS += -lresolv -lsocket -lnsl
endif

CFLAGS += $(OFLAGS) $(DFLAGS) -I. -I../bncsutil/src/ -I../StormLib/

ifeq ($(SYSTEM),Darwin)
CFLAGS += -I../mysql/include/
endif

CFLAGS += $(EXTRA_CFLAGS)
LFLAGS += $(EXTRA_LFLAGS)

OBJS = bncsutilinterface.o bnet.o bnetprotocol.o bnlsclient.o bnlsprotocol.o commandpacket.o config.o crc32.o game.o game_base.o gameplayer.o gameprotocol.o gameslot.o gcbiprotocol.o ghost.o ghostdb.o ghostdbmysql.o gpsprotocol.o language.o map.o ohconnect.o packed.o replay.o savegame.o sha1.o socket.o stats.o statsdota.o statsw3mmd.o util.o
COBJS =
PROGS = ./ghost++

all: $(OBJS) $(COBJS) $(PROGS)

./ghost++: $(OBJS) $(COBJS)
	$(CXX) -o ./ghost++ $(OBJS) $(COBJS) $(LFLAGS)

clean:
	rm -f $(OBJS) $(COBJS) $(PROGS)

$(OBJS): %.o: %.cpp
	$(CXX) -o $@ $(CFLAGS) -c $<

$(COBJS): %.o: %.c
	$(CC) -o $@ $(CFLAGS) -c $<

./ghost++: $(OBJS) $(COBJS)

all: $(PROGS)

bncsutilinterface.o: ghost.h includes.h util.h bncsutilinterface.h
bnet.o: ghost.h includes.h util.h config.h language.h socket.h commandpacket.h ghostdb.h bncsutilinterface.h bnlsclient.h bnetprotocol.h bnet.h map.h packed.h savegame.h replay.h gameprotocol.h game_base.h
bnetprotocol.o: ghost.h includes.h util.h bnetprotocol.h
bnlsclient.o: ghost.h includes.h util.h socket.h commandpacket.h bnlsprotocol.h bnlsclient.h
bnlsprotocol.o: ghost.h includes.h util.h bnlsprotocol.h
commandpacket.o: ghost.h includes.h commandpacket.h
config.o: ghost.h includes.h config.h
crc32.o: ghost.h includes.h crc32.h
game.o: ghost.h includes.h util.h config.h language.h socket.h ghostdb.h bnet.h map.h packed.h savegame.h gameplayer.h gameprotocol.h game_base.h game.h stats.h statsdota.h statsw3mmd.h
game_base.o: ghost.h includes.h util.h config.h language.h socket.h ghostdb.h bnet.h map.h packed.h savegame.h replay.h gameplayer.h gameprotocol.h game_base.h next_combination.h
gameplayer.o: ghost.h includes.h util.h language.h socket.h commandpacket.h bnet.h map.h gameplayer.h gameprotocol.h gpsprotocol.h game_base.h gcbiprotocol.h
gameprotocol.o: ghost.h includes.h util.h crc32.h gameplayer.h gameprotocol.h game_base.h
gameslot.o: ghost.h includes.h gameslot.h
gcbiprotocol.o: gcbiprotocol.h ghost.h util.h
ghost.o: ghost.h includes.h util.h crc32.h sha1.h config.h language.h socket.h ghostdb.h ghostdbmysql.h bnet.h map.h packed.h savegame.h gameplayer.h gameprotocol.h gpsprotocol.h game_base.h game.h gcbiprotocol.h ohconnect.h
ghostdb.o: ghost.h includes.h util.h config.h ghostdb.h
ghostdbmysql.o: ghost.h includes.h util.h config.h ghostdb.h ghostdbmysql.h
gpsprotocol.o: ghost.h util.h gpsprotocol.h
language.o: ghost.h includes.h config.h language.h
map.o: ghost.h includes.h util.h crc32.h sha1.h config.h map.h
ohconnect.o: ghost.h socket.h ohconnect.h
packed.o: ghost.h includes.h util.h crc32.h packed.h
replay.o: ghost.h includes.h util.h packed.h replay.h gameprotocol.h
savegame.o: ghost.h includes.h util.h packed.h savegame.h
sha1.o: sha1.h
socket.o: ghost.h includes.h util.h socket.h
stats.o: ghost.h includes.h stats.h
statsdota.o: ghost.h includes.h util.h ghostdb.h gameplayer.h gameprotocol.h game_base.h stats.h statsdota.h
statsw3mmd.o: ghost.h includes.h util.h ghostdb.h gameprotocol.h game_base.h stats.h statsw3mmd.h
util.o: ghost.h includes.h util.h
