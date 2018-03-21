
%token DIGIT TIMES PLUS LPAREN RPAREN

%%
line	:   expr '\n'		
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


