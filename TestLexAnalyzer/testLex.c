/* Test a flex file on program making sure all tokens are recognized correctly.
 * Author MMM 2018
 */
#include<stdio.h>
int yylex();

#include "struct.h" 
#include "core2.tab.h"
YYSTYPE yylval;

extern char *yytext;

char *toTokenName();

void
main(){

   int tokenCode = 0;
   
   while((tokenCode = yylex()) != 0){

        printf("Token returned = %d\tlexeme=%s\t TokenDefinedConstant=%s\n", tokenCode, yytext, toTokenName(tokenCode));

   }
}
