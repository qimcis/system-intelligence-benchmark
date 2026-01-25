CC = gcc
CFLAGS = -Wall -Werror -pthread -O
LDFLAGS = -pthread

all: wordcount

# The mapreduce library
mapreduce.o: mapreduce.c mapreduce.h
	$(CC) $(CFLAGS) -c mapreduce.c

# Sample wordcount program for testing
wordcount: wordcount.c mapreduce.o
	$(CC) $(CFLAGS) -o wordcount wordcount.c mapreduce.o $(LDFLAGS)

clean:
	rm -f *.o wordcount

.PHONY: all clean
