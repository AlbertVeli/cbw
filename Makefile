CFLAGS = -g

# Object files for for the workbench.
cbreq =	pword.o lpair.o approx.o \
		eclass.o cipher.o char-io.o \
		tritab.o autotri.o pqueue.o \
		webster.o user.o gblock.o dblock.o dbsaux.o banner.o \
		cblocks.o stats.o parser.o knit.o \
		pgate.o perm.o terminal.o \
		keylib.o windowlib.o dline.o screen.o 

# The main program.
cbw: start.o $(cbreq) 
	cc $(CFLAGS) start.o $(cbreq) \
	-lcurses -ltermcap -lm -o cbw

# Program to decrypt files after they have been broken by CBW.
zeecode: zeecode.o
	cc $(CFLAGS) zeecode.o -o zeecode

# Program to encrypt files, this is identical to the
# Unix crypt function based on a two rotor enigma.
enigma: enigma.o
	cc $(CFLAGS) enigma.o -o enigma

#
# The remaining files are test drivers.
#

bd: bdriver.o $(cbreq)
	cc -g bdriver.o $(cbreq) -lm \
	-lcurses -ltermcap -lm -o bd

sd: sdriver.o $(cbreq)
	cc -g sdriver.o $(cbreq) \
	-lcurses -ltermcap -lm -o sd

approx: approx.o
	cc -g approx.o -lm -o approx

stats: stats.o char-io.o
	cc -g stats.o char-io.o -lm -o stats

tri: tdriver.o $(cbreq)
	cc -g tdriver.o $(cbreq) -lm \
	-lcurses -ltermcap -lm -o tri

ectreq = edriver.o eclass.o cipher.o char-io.o \
		triglist.o \
		webster.o user.o gblock.o dblock.o dbsaux.o banner.o \
		cblocks.o trigram.o stats.o parser.o knit.o \
		pgate.o perm.o \
		keylib.o windowlib.o dline.o screen.o 


ect: $(ectreq)
	cc -g $(ectreq) -lm \
	-o ect

ptt: char-io.o probtab.o
	cc -g char-io.o probtab.o -lm -o ptt

dt: disptest.o keylib.o windowlib.o screen.o
	cc disptest.o keylib.o windowlib.o screen.o -o dt

triplace: triplace.o


