DBGFLAGS = -g -O0

CFLAGS = $(DBGFLAGS) -W -Wall

LIBS = -lcurses -ltermcap -lm


# Object files for for the workbench.
cbreq =	pword.o lpair.o approx.o \
		eclass.o cipher.o char-io.o \
		tritab.o autotri.o pqueue.o \
		webster.o user.o gblock.o dblock.o dbsaux.o banner.o \
		cblocks.o stats.o parser.o knit.o \
		pgate.o perm.o terminal.o \
		keylib.o windowlib.o dline.o screen.o 

all: cbw zeecode enigma bd sd approx stats tri

# The main program.
cbw: start.o $(cbreq) 
	$(CC) $(CFLAGS) start.o $(cbreq) \
	-o cbw $(LIBS)

# Program to decrypt files after they have been broken by CBW.
zeecode: zeecode.o
	$(CC) $(CFLAGS) zeecode.o -o zeecode

# Program to encrypt files, this is identical to the
# Unix crypt function based on a two rotor enigma.
enigma: enigma.o
	$(CC) $(CFLAGS) enigma.o -o enigma

#
# The remaining files are test drivers.
#

bd: bdriver.o $(cbreq)
	$(CC) $(CFLAGS) bdriver.o $(cbreq) -lm \
	-o bd $(LIBS)

sd: sdriver.o $(cbreq)
	$(CC) $(CFLAGS) sdriver.o $(cbreq) \
	-o sd $(LIBS)

approx: approx.c
	$(CC) $(CFLAGS) -DAPPROX_STANDALONE -o approx approx.c -lm

stats: stats.c char-io.o approx.o
	$(CC) $(CFLAGS) -DSTATS_STANDALONE -o stats stats.c char-io.o approx.o -lm

tri: tdriver.o $(cbreq)
	$(CC) $(CFLAGS) tdriver.o $(cbreq) -lm \
	-o tri $(LIBS)

ectreq = edriver.o eclass.o cipher.o char-io.o \
		webster.o user.o gblock.o dblock.o dbsaux.o banner.o \
		cblocks.o stats.o parser.o knit.o \
		pgate.o perm.o \
		keylib.o windowlib.o dline.o screen.o 
#		trigram.o triglist.o


ect: $(ectreq)
	$(CC) $(CFLAGS) $(ectreq) -lm \
	-o ect

ptt: char-io.o probtab.o
	$(CC) $(CFLAGS) char-io.o probtab.o -lm -o ptt

dt: disptest.o keylib.o windowlib.o screen.o
	$(CC) $(CFLAGS) disptest.o keylib.o windowlib.o screen.o -o dt

#triplace: triplace.o


.PHONY: clean

clean:
	rm -f cbw start.o $(cbreq) zeecode zeecode.o enigma enigma.o bd bdriver.o sd sdriver.o approx stats tri tdriver.o ect $(ectreq) ptt probtab.o dt disptest.o *~
