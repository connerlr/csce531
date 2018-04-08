%{
#include <ctype.h>
#include <stdio.h>
#define YYDEBUG 1
#define ADDOP  301
#define MULTOP 302

/* $Header: gram,v 1.1 84/12/07 12:01:01 matthews Exp $  */

#define YYDEBUG 1


extern char *yytext;
char *newtemp();
void gen(int, char *, char *, char *);


%}
%union{
     char *place;
     int  ival;
}
%type <place> expr
%token <ival> INT
%token <place> ID
%token DEBUG
%left '+' '-'
%left '*' '/'
%%
task:
	task expr ';' 		{
				 printf("\nEND \n");
				}
    |   task ';'
    |   task DEBUG ';'		{ if(yydebug == 0) yydebug=1; else yydebug = 0;}
    |    /* epsilon */
    ;

expr:
	expr '+' expr 		{ 
				$$ = newtemp();
				gen(ADDOP,$1, $3, $$);
				}
    |
	expr '*' expr 		{ 
				$$ = newtemp();
				gen(MULTOP,$1, $3, $$);
				}
    |
	ID			{
				$<place>$ = yylval.place;
				}
    ;
%%
char *
newtemp(){
   static int number = 0;
   char s[32];
   char *retval, *strdup();

   sprintf(s,"#T%d",number);
/*   printf("\nNEWTEMP  %s",s);	*/
   number = number + 1;
   retval = strdup(s);
   return(retval);
}

void 
gen(int op, char *p1, char *p2, char *r)
{
    static int quadnumber = 0;

    quadnumber = quadnumber + 1;
    putchar('\n');
    printf("%d\t", quadnumber);
    switch (op){
    case ADDOP:
	      printf("ADD\t");
	   break;
    case MULTOP:
	      printf("MULT\t");
	   break;
    default:
	   printf("Error in OPcode Field");
    }

    printf("%s\t", p1);
    printf("%s\t", p2);
    printf("%s\t", r);
}

