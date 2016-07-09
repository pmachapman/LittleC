CC = bcc32
LIBS = -L"C:\Borland\BCC55\Lib"
INCS = -I"C:\Borland\BCC55\Include"
CFLAGS = -P -O2 -w $(LIBS) $(INCS)

all:
		$(CC) $(CFLAGS) ../src/littlec.c ../src/parser.c ../src/lclib.c

clean:
		del *.obj
		del littlec.exe
