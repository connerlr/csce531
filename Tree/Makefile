# Note  yacc -d and yacc -v must be done explicitly
#
YACC=bison
CC = gcc
LEX= flex

tree: tree.tab.o lex.yy.o kr.symtab.o
	$(CC) -DYYDEBUG tree.tab.o lex.yy.o kr.symtab.o -ly -lfl -o tree

tree.tab.c: tree.y
	bison tree.y

tree.tab.h:
	bison -d tree.y

lex.yy.c: tree.l tree.tab.h
	flex tree.l

tree.output: tree.y
	bison --report=all tree.y
clean: 
	-rm -f tree lex.yy.c tree.tab.c *.o
