%{
yydebug=1;
%}
%token DIGIT TIMES PLUS LPAREN RPAREN PROGRAM BEGINT ENDT IDENTIFIER INT COLON COMMA SEMICOLON INPUT EQUALS OUTPUT

%%
program : PROGRAM declaration BEGINT statement ENDT SEMICOLON {printf("recognized a program\n");} 
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
identifier :    IDENTIFIER
	|       COMMA PLUS IDENTIFIER
	;

statement : 	assignmentstatement
	|   	outputstatement
	|	inputstatement
	|       assignmentstatement statement
	|	outputstatement statement
	|	inputstatement  statement
	;

assignmentstatement : IDENTIFIER COLON EQUALS expr;
outputstatement : INPUT identifier;
inputstatement : OUTPUT identifier;
declaration: 	type COLON identifier SEMICOLON             {printf("recognized a declaration\n");}
	| 	type COLON identifier SEMICOLON	declaration
	;
type: INT
	;


%%


