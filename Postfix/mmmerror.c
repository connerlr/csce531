/*
 *	yyerror() -- detailed error message for yyparse()
 *	from comp. Construction under UNIX Schreiner and Friedman
 */

#include <stdio.h>

extern int yylineno;

void
mywhere(){
   fprintf(stderr, "line %d", yylineno);
}


// FILE *yyerfp = stdout;

void
yyerror(char *s, char *t)
{
    extern int yynerrs;
    static int list = 0;

    if(s || ! list){
	fprintf(stderr, "[error %d] ", yynerrs+1);
	mywhere();
	if(s){
	    fputs(s, stderr);
	    putc('\n', stderr);
	    return;
	}
	if(t){
	    fputs("expecting: ", stderr);
	    fputs(t, stderr);
	    list = 1;
	    return;
	}
	fputs("syntax error\n",stderr);
	return;
    }
    if(t){
        putc(' ', stderr);
        fputs(t, stderr);
        return;
    }
    putc('\n', stderr);
    list = 0;

}

