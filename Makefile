PREFIX = /opt/skytraxx3/image/skytraxx_VF_V1.0/rootfs/usr/local
CROSS_COMPILE = /opt/skytraxx3/oe-core/build/out-glibc/sysroots/x86_64-linux/usr/bin/arm-angstrom-linux-gnueabi/arm-angstrom-linux-gnueabi-
CC = $(CROSS_COMPILE)gcc
INSTALL = install

CFLAGS += -Wall -g -O3 -march=armv7-a -mthumb -mthumb-interwork -mfloat-abi=hard -mfpu=neon -I/usr/local/oecore-x86_64/sysroots/armv7at2hf-vfp-neon-angstrom-linux-gnueabi/usr/include
LDFLAGS += --sysroot=/usr/local/oecore-x86_64/sysroots/armv7at2hf-vfp-neon-angstrom-linux-gnueabi -L/usr/local/oecore-x86_64/sysroots/armv7at2hf-vfp-neon-angstrom-linux-gnueabi/usr/lib -Wl,-rpath-link,/usr/local/oecore-x86_64/sysroots/armv7at2hf-vfp-neon-angstrom-linux-gnueabi/usr/lib -L/usr/local/oecore-x86_64/sysroots/armv7at2hf-vfp-neon-angstrom-linux-gnueabi/lib -Wl,-rpath-link,/usr/local/oecore-x86_64/sysroots/armv7at2hf-vfp-neon-angstrom-linux-gnueabi/lib -mfloat-abi=hard

OBJS =	dev_table.o	\
	i2c.o		\
	init.o		\
	main.o		\
	port.o		\
	serial_common.o	\
	serial_platform.o	\
	stm32.o		\
	utils.o

LIBOBJS = parsers/parsers.a

all: stm32flash

serial_platform.o: serial_posix.c serial_w32.c

parsers/parsers.a: force
	cd parsers && $(MAKE) parsers.a

stm32flash: $(OBJS) $(LIBOBJS)
	$(CC) $(LDFLAGS) -o $@ $(OBJS) $(LIBOBJS)

clean:
	rm -f $(OBJS) stm32flash
	cd parsers && $(MAKE) $@

install: all
	$(INSTALL) -d $(DESTDIR)$(PREFIX)/bin
	$(INSTALL) -m 755 stm32flash $(DESTDIR)$(PREFIX)/bin
#	$(INSTALL) -d $(DESTDIR)$(PREFIX)/share/man/man1
#	$(INSTALL) -m 644 stm32flash.1 $(DESTDIR)$(PREFIX)/share/man/man1

force:

.PHONY: all clean install force
