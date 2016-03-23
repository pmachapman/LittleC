all:		parser.o littlec.o lclib.o
		gcc -o littlec parser.o littlec.o lclib.o

clean:
		rm *.o

parser.o:	parser.c
		gcc -c parser.c

littlec.o:	littlec.c
		gcc -c littlec.c

lclib.o:	lclib.c
		gcc -c lclib.c
