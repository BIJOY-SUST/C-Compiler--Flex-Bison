%{
#include <stdlib.h>
void yyerror(char *);
#include "y.tab.h"

%}
    
%%

    /* variables */
[a-z]           {
                    // yylval = *yytext - 'a';
                    yylval = yytext[0] - 'a';
                    return VARIABLE;
                }

    /* integers */
[0-9]+          {
                    yylval = atoi(yytext);
                    return INTEGER;
                }

    /* operators */
[-+()=/*\n]     {
                    // return *yytext;
                    return yytext[0];
                }

    /* skip whitespaces */ 
[ \t]           /* do nothing */

    /* undefined */
.               yyerror("invalid character");




%%


int yywrap (void )
{
    return 1;
}