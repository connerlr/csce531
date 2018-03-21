
%{
#include "simple3.tab.h"
%}


digit [0-9]+

%%
\n	return('\n');
\+	return(PLUS);
\*	return(TIMES);
\(	return(LPAREN);
\)	return(RPAREN);
{digit}    return(DIGIT);
%%

yywrap(){

}
