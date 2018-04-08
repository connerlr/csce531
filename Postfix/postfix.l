
integer		[0-9]+
real		[0-9]+\.(E(\-|"+")?(0-9)+)?
string		(\"[^\"^\n]*\")|(\'[^\'^\n]\')
%option yylineno
%{
#include <stdio.h>
#include <ctype.h>
#include "postfix.tab.h"

struct hashlist{
	char *name;
	int  val;
	struct hashlist *next;
	struct hashlist *tnext;
	} *tmp;
extern struct hashlist *lookup();
extern struct hashlist *install();
extern char *strsave();
%}

WHITE		       [ \t\n]
D                      [0-9]
%%
"{"[^\}]*"}"                        {printf("FOUND A COMMENT");}
[ \t]                               ;
\n                     {} //return('\n');
(\-|\+)?{D}+            { yylval.place = strdup(yytext);
                          return(INT);
			}
"+"                    return('+');
"-"                    return('-');
"*"                    return('*');
"/"                    return('/');
";"                    return(';');
"debug"		       return(DEBUG);
[a-zA-Z_][a-zA-Z_]*    {yylval.place = strdup(yytext); 
			 return(ID);
		       }
.                     printf ("\nUndefined Character: '%s'",yytext);
%%
