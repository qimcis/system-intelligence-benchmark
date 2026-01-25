CC = gcc
CFLAGS = -Wall -Werror -O2 -Iinclude

all: xfsck

xfsck: xfsck.c
	$(CC) $(CFLAGS) -o xfsck xfsck.c

clean:
	rm -f xfsck

.PHONY: all clean
