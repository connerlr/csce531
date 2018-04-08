
integer		[0-9]+
real		[0-9]+\.(E(\-|"+")?(0-9)+)?
string		(\"[^\"^\n]*\")|(\'[^\'^\n]\')
%{
#include <stdio.h>
#include <ctype.h>
#include "tree.tab.h"

struct hashlist{
	char *name;
	int  val;
	struct hashlist *next;
	struct hashlist *tnext;
	} *tmp;
extern struct hashlist *lookup();
extern struct hashlist *install();


%}
WHITE		       [ \t\n]
D                      [0-9]
%%
"{"[^\}]*"}"                        {printf("FOUND A COMMENT");}
[ \t]                               ;
"\n"                   return('\n');
(\-|\+)?{D}+            {
			}
"+"                    return('+');
"-"                    return('-');
"*"                    return('*');
"/"                    return('/');
";"                    return(';');
[a-zA-Z_][a-zA-Z_]*    { yylval.cval = (char *) strdup(yytext);
			 return(ID);
		       }
.                     printf ("\nUndefined Character: '%s'",yytext);
%%
