
%token DIGIT

%%
expr	:	expr '+' expr	
	|	expr '*' expr	
	|	'('  expr  ')'	
	|	DIGIT
	;
%%


