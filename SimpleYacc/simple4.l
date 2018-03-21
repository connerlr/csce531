/*
 * Simple lex that returns the token code INTEGER
 * and the value of that integer in yylval.
 */

%{
#include "simple4.tab.h"
%}


num [0-9]+

%%
\n	return('\n');
\+	return(PLUS);
\*	return(TIMES);
\(	return(LPAREN);
\)	return(RPAREN);
{num}    { yylval= atoi(yytext); return(INTEGER);}
%%

yywrap(){

}
