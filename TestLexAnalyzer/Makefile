
runTests: testLex test8
	./testLex < test8   // run testLex on the program in the file test8


testLex: testLex.c lex.yy.o core2.tab.h toName.o
	gcc testLex.c lex.yy.o toName.o -o testLex


toName.o: toName.c core2.tab.h regexp.py
	python3 regexp.py > toName.c
	gcc -c toName.c

clean: 
	rm lex.yy.o toName.o testLex
