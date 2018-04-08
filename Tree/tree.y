%{
#include <ctype.h>
#include <stdio.h>
#define YYDEBUG 1

/* $Header: gram,v 1.1 84/12/07 12:01:01 matthews Exp $  */

typedef struct 	TNODE	{
	char	*info;
	int	tag;
	struct   TNODE   *left;	
	struct   TNODE   *right;
}TREENODE, *TREEPTR;

TREEPTR talloc();

#define YYDEBUG 1
int yydebug=1;

extern char *yytext;
extern TREEPTR talloc();
TREEPTR tmp;

void treeprint();

%}
%union {
/*     struct  TNODE   {
        char    *info;
        int     tag;
        struct   TNODE   *left;
        struct   TNODE   *right;
     }  *pval;
 */
     TREEPTR pval;
     char    *cval;
     int      ival;
     }
%type <pval> expr
%token <ival> INT
%token <cval> ID
%left '+' '-'
%left '*' '/'
%%
task:
	task expr ';' 		{
				 printf("\nDumping tree\n");
				 treeprint($2);
				 printf("\n");
				}
    |   task ';'
    |    /* epsilon */
    ;
expr:
	expr '+' expr 		{ 
				$$ = talloc();
				$$ -> tag = '+';
				$$ -> left = $1;
				$$ -> right = $3;
				}
    |
	expr '*' expr 		{ 
				$$ = talloc();
				$$ -> tag = '*';
				$$ -> left = $1;
				$$ -> right = $3;
				}
    |
	ID			{
				$$ = talloc();
				$$ -> tag = ID;
				$$ -> info = yylval.cval;
			/*
				printf("reducing E -> ID: yylval.cval %s",yylval.cval);
			*/
				$$ -> left = NULL;
				$$ -> right = NULL;
				}
    ;
%%

/*recursive tree print routine p133 K&R */
void 
treeprint(TREENODE *p)
{
	if(p == NULL) return;
	switch(p ->tag){
	case ID:
		printf("\n ID ");
		printf(" %s ", p -> info);
		break;
	case '+':
	case '*':
	case '-':
	case '/':
		printf("\n %c ", p -> tag);
		treeprint(p -> left);
		treeprint(p -> right);
		break;
	default:
		printf("error in tree: tag is %d", p -> tag);
	}
}

TREEPTR talloc()
{
	void *malloc();
	TREENODE *tp;
	tp = (TREENODE *)malloc(sizeof(*tp));
	if (tp == NULL){
		printf("out of memory space");
		return (NULL); 
	}
	return(tp);	/*return pointer*/
}
