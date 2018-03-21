%{
#include <ctype.h>

int yyleng;
// int yylineno = 1;
yydebug=1;

%}

%token INTEGER PLUS TIMES LPAREN RPAREN

%%
line	:   expr '\n'			{printf("Exression =%d\n", $1);}
	|   line expr '\n'		{printf("Exression =%d\n", $2);}
	;
expr	:	expr PLUS term		{$$ = $1 + $3;}
	|	term
	;
term	:	term TIMES factor	{$$ = $1 * $3;}
	|	factor
	;
factor	:	LPAREN expr RPAREN	{$$ = $2;}
	|	INTEGER			{$$ = yylval;} /* the default action */
	;
%%
