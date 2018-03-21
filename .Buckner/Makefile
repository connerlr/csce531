##
#
#  Makefile for Simple Yacc and Lex examples 
#
#
###
CC=gcc
CFLAGS=
CFLAGS=-DYYDEBUG
LEX=flex
YACC=bison
YACCFLAGS=
YACCFLAGS=-t 

core2: core2.tab.o lex.yy.o
	$(CC) $(CFLAGS) core2.tab.o lex.yy.o -ly -o core2

core2.tab.o: core2.tab.c
	$(CC) $(CFLAGS) -c core2.tab.c 
	
core2.tab.h: core2.y
	bison -d $(YACCFLAGS) core2.y

core2.tab.c: core2.y
	bison $(YACCFLAGS) core2.y

lex.yy.o: lex.yy.c
	$(CC) $(CFLAGS) -c lex.yy.c 

lex.yy.c: core2.l
	flex core2.l 

clean:
	-rm *.o lex.yy.c *.tab.[ch] core2[0-9] *.output *.act 
