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

simple3: simple3.tab.h simple3.tab.o lex.yy.o
	$(CC) $(CFLAGS) simple3.tab.o lex.yy.o -ly -o simple3

simple3.tab.h: simple3.y
	bison -d $(YACCFLAGS) simple3.y

simple3.tab.c: simple3.y
	bison $(YACCFLAGS) simple3.y

lex.yy.c: simple3.l
	flex simple3.l 

clean:
	-rm *.o lex.yy.c *.tab.[ch] simple[0-9] *.output *.act 
