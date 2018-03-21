%{
#include <ctype.h>
char yytext[250];
int yyleng;
int yylineno = 1;
%}

%token DIGIT

%%
line	:   expr '\n'		{printf("%d\n", $1);}
	;
expr	:	expr '+' term	{$$ = $1 + $3;}
	|	term
	;
term	:	term '*' factor	{$$ = $1 * $3;}
	|	factor
	;
factor	:	'('  expr  ')'	{$$ = $2;}
	|	DIGIT
	;
%%
yylex(){
   int c;
   c = getchar();
   yytext[0] = c;
   yytext[1] = '\0';
   yyleng = 1;
   if(isdigit(c)){
       yylval = c - '0';
       return DIGIT;
   }
   if (c == '\n') ++yylineno;
   return c;
}


