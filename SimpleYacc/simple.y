
%token DIGIT

%%
line	:   expr '\n'		
	;
expr	:	expr '+' term	
	|	term
	;
term	:	term '*' factor	
	|	factor
	;
factor	:	'('  expr  ')'	
	|	DIGIT
	;
%%


