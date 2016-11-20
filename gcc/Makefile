CC = gcc
CFLAGS = -O -Wall -Wextra

all:	littlec

littlec:		parser.o littlec.o lclib.o
		$(CC) $(CFLAGS) -o littlec parser.o littlec.o lclib.o

clean:
		rm *.o
		rm littlec

parser.o:	../src/parser.c
		$(CC) $(CFLAGS) -c -o parser.o ../src/parser.c

littlec.o:	../src/littlec.c
		$(CC) $(CFLAGS) -c -o littlec.o ../src/littlec.c

lclib.o:	../src/lclib.c
		$(CC) $(CFLAGS) -c -o lclib.o ../src/lclib.c
