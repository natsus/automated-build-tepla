CC = gcc
LIBS = -ltepla -lcrypto -lgmp
CFLAGS  = -Wall -g -O4

TARGET = sample.exe
LIBDIR = -L/usr/local/lib
INCDIR = -I/usr/local/include

all: $(TARGET)

%.exe: %.o
	$(CC) $(CFLAGS) -o $@ $< $(INCDIR) $(LIBDIR) $(LIBS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< $(INCDIR)

.PHONY: clean
clean:
	$(RM) *~ $(TARGET)
