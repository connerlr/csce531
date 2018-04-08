# Note  yacc -d and yacc -v must be done explicitly
#
YACC=bison
CC = gcc
LEX= flex
YACCFLAGS= -t

postfix: postfix.tab.o lex.yy.o mmmerror.o postfix.tab.h
	$(CC) -DYYDEBUG postfix.tab.o lex.yy.o mmmerror.o -ly -lfl -o postfix

postfix.tab.o: postfix.tab.c

postfix.tab.c: postfix.y
	$(YACC) postfix.y

postfix.tab.h: postfix.y 
	$(YACC) -d postfix.y

lex.yy.c: postfix.l
	flex postfix.l

clean: 
	-rm -f *.o postfix lex.yy.c postfix.tab.c 
