%{
#include <ctype.h>
#include <stdio.h>
#define YYDEBUG 1
/* Some defines for opcode field of intermediate code */
#define ADDOP  	401
#define MULTOP	402
#define GOTO	407

#define YYDEBUG 1


extern char *yytext;

char *newtemp();
typedef struct node{
		int quadnum;
		struct node *link;
		} *LIST, LISTNODE;

#define CODESIZE 1000
int opcode[CODESIZE];
char *op1[CODESIZE], *op2[CODESIZE], *target[CODESIZE];
char *VOID = "#VOID";

LIST tmplist;
int nextquad = 0;

LIST makelist(int);
LIST  merge(LIST, LIST);

int backpatch_verbose = 1;
%}

%union{
     char *place;
     struct {
	  LIST  *true;
	  LIST  *false;
	  } list;
     int quad;
     int type;
     LIST next;
}

%type <place> expr
%type <list> B
%type <quad> M
%type <next> N
%type <next> L
%type <next> S
%token <place> INT
%token <type> RELOP
%token  IF
%token  THEN
%token  ELSE
%token  AND
%token  ASSIGNOP
%token  OR
%token  NOT
%token  PROGRAM
%token  BEGN
%token  END WHILE DO ENDLOOP
%token  LT	/* not really token, used to place def in y.tab.h */
%token  GT	/* not really token, used to place def in y.tab.h */
%token  EQ	/* not really token, used to place def in y.tab.h */
%token <place> ID
%left '+' '-'
%left '*' '/'
%%
program:
	PROGRAM BEGN L END	 {
				 dumpcode();
				 printf("\nEND \n");
				 exit(0);
				 }
    ;

L:	S			{$<next>$=$<next>1;}
    |	L M S			{
				 dl("$<next>1=", $<next>1); 
				 printf("M.quad=%d; ", $2);
				 dl("$<next>3=", $<next>3); 
				 
				 backpatch($<next>1,$2);
				 $<next>$=$<next>3;
				}
    ;

expr:
	expr '+' expr 		{ 
				$<place>$ = newtemp();
				gen(ADDOP,$<place>1, $<place>3, $<place>$);
				}
    |
	expr '*' expr 		{ 
				$<place>$ = newtemp();
				gen(MULTOP,$<place>1, $<place>3, $<place>$);
				}
    |
	ID			{
				$<place>$ = yylval.place;
				}
    ;
B:
	ID RELOP ID 		{
				gen($2, $1, $3, VOID);
				gen(GOTO, VOID, VOID, VOID);
				 dumpcode();
				$$.true = makelist(nextquad -2);
				$$.false = makelist(nextquad - 1);
				}
     |  B AND M B		{
				 dl("\n$1.t=", $1.true); 
				 dl("\n$1.f=", $1.false); 
				 printf("\nM.quad=%d; ", $3);
				 dl("\n$4.t=", $4.true); 
				 dl("\n$4.f=", $4.false); 
				backpatch($1.true,$3);
				$$.true = $4.true;
				$$.false = merge($1.false, $4.false);
				 dl("\n$$.t=", $$.true); 
				 dl("\n$$.f=", $$.false); 
				 dumpcode();
				}
     |  '(' B ')'		{
				$$.true = $2.true;
				$$.false = $2.false;
				}
     ;
S: ID ASSIGNOP expr  		{
				gen(ASSIGNOP, $<place>3, VOID, $1);
				$$ = NULL;
				}
     |   IF B THEN M S ELSE N M S {
				 dl("\n$2.t=", $2.true); 
				 dl("\n$2.f=", $2.false); 
				 printf("\nM1.quad=%d; ", $4);
				 dl("\n$<next>5=", $<next>5); 
				 dl("\n$<next>7=", $<next>7); 
				 printf("\nM2.quad=%d; ", $8);
				 dl("\n$<next>9=", $<next>9); 

				fprintf(stderr,"IF ELSE- code before backpatching\n");
				dumpcode();
				backpatch($2.true, $4);
				backpatch($2.false, $8);
				tmplist = merge($5, $7);
				$$ = merge(tmplist, $9);
				dl("$<next>$ =", $$);
				fprintf(stderr,"IF ELSE- code after backpatching\n");
				dumpcode();
				}
     ;
M:				{$$ = nextquad;}
     ;
N:				{gen(GOTO, VOID, VOID, VOID);
			 	$$ = makelist(nextquad - 1);
				}
     ;
%%
void 
dumplist(LIST  p)
{
   printf("{");
   while (p != NULL){
        printf("%d, ", p->quadnum);
	p = p -> link;
   }
   printf("}");
}

void
dl(char *label, LIST p){
    printf("%s", label);
    dumplist(p);
}

LIST makelist(int  q)
{
   LIST    tmp;
   void    *malloc();
   tmp = (LISTNODE *) malloc(sizeof (LISTNODE));
   tmp -> quadnum = q;
   return(tmp);
}

void 
backpatch(LIST  p, int q)
{
   if(backpatch_verbose)
     {printf("\nBackpatching Quads:");}

   while (p != NULL){
        if(backpatch_verbose) printf("%d, ", p->quadnum);
	target[p->quadnum] = (LISTNODE *) q;
	p = p -> link;
   }
   if(backpatch_verbose) printf("to %d\n", q);
}

LIST  merge(LIST  p1, LIST p2)
{
   LIST  tmp;
   tmp = p1;
   if (tmp == NULL) return(p2);
   while((tmp->link) != NULL){
	tmp = tmp -> link;
   }
   tmp -> link = p2;
   return(p1);
}

char *
newtemp(){
   static int number = 0;
   char s[32];
   char *retval;

   sprintf(s,"#tmp%d",number);
/*   printf("\nNEWTEMP  %s",s);	*/
   number = number + 1;
   retval = strdup(s);
   return(retval);
}


gen(int op, char *p1, char *p2, char *r)
{
    opcode[nextquad] = op;
    op1[nextquad] = p1;
    op2[nextquad] = p2;
    target[nextquad] = r;
    nextquad = nextquad + 1;
}

dumpcode(){
    int i;
    printf("\nDumping code generated to this point:");
    for(i = 0; i < nextquad; ++i){
       printf("\n");
       printf("%d\t", i);
       switch (opcode[i]){
       case ADDOP:
	      	 printf("%s\t%s\t%s", op1[i], op2[i], target[i]);
	         printf("ADD\t");
	      break;
       case MULTOP:
	         printf("MULT\t");
	      	 printf("%s\t%s\t%s", op1[i], op2[i], target[i]);
	      break;
       case AND:
	         printf("AND\t");
	      	 printf("%s\t%s\t%s", op1[i], op2[i], target[i]);
	      break;
       case ASSIGNOP:
	         printf("ASSIGN\t");
	      	 printf("%s\t%s\t%s", op1[i], op2[i], target[i]);
	      break;
       case GOTO:
	         printf("GOTO\t");
	      	 if(target[i] != VOID)
		    printf("%s\t%s\t%d", op1[i], op2[i], target[i]);
	      	 else printf("%s\t%s\tVOID", op1[i], op2[i]);
	      break;
       case LT:
	         printf("if <\t");
	      	 if(target[i] != VOID)
		    printf("%s\t%s\t%d", op1[i], op2[i], target[i]);
	      	 else printf("%s\t%s\tVOID", op1[i], op2[i]);
	      break;
       default:
	      printf("Error in OPcode Field");
	      printf("%s\t%s\t%s", op1[i], op2[i], target[i]);
       }

    }
}

