CROSS_COMPILE = /opt/skytraxx3/oe-core/build/out-glibc/sysroots/x86_64-linux/usr/bin/arm-angstrom-linux-gnueabi/arm-angstrom-linux-gnueabi-
AR = $(CROSS_COMPILE)ar
CC = $(CROSS_COMPILE)gcc
CFLAGS += -Wall -g -O3 -march=armv7-a -mthumb -mthumb-interwork -mfloat-abi=hard -mfpu=neon -I/usr/local/oecore-x86_64/sysroots/armv7at2hf-vfp-neon-angstrom-linux-gnueabi/usr/include

all: parsers.a

parsers.a: binary.o hex.o
	$(AR) rc $@ binary.o hex.o

clean:
	rm -f *.o parsers.a

.PHONY: all clean
