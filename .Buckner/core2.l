
%{
#include "core2.tab.h"
%}


digit [0-9]+
word [a-z][A-Z]+
%%
[ ]
[a-z]+  {return(IDENTIFIER); printf("should set yylval = ...\n");}
\n	//return('\n');
\+	return(PLUS);
\*	return(TIMES);
\(	return(LPAREN);
\)	return(RPAREN);
{digit}    return(DIGIT);
program  {printf("PROGRAM"); return(PROGRAM);}
end  	{return(ENDT);}
begin    return(BEGINT);
int    	return(INT);
\:	return(COLON);
\,	return(COMMA);
\;	return(SEMICOLON);
\=     return(EQUALS);
.      { printf("need action lexeme='%s'\n", yytext);} 
%%


int main(void){
    yyin = fopen("core3.txt", "r"); 
    int token = 0;
        while((token = yylex()) != 0);
    return 0;
}

int yywrap(){

return 1;

}

void yyerror(const char *str)
{
 fprintf(stderr,"error: %s\n",str);
}

