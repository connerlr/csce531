%{
yydebug=1;
%}
%token DIGIT TIMES PLUS LPAREN RPAREN

%%
line	:   expr '\n'			{printf("recognized an expr\n");
					 exit(0);
					}
	;
expr	:	expr PLUS term	
	|	term
	;
term	:	term TIMES factor	
	|	factor
	;
factor	:	LPAREN  expr  RPAREN	
	|	DIGIT
	;
%%


