%{
    #include <stdlib.h>
    #include<stdio.h>
    #include "y.tab.h"

%}

%%
0  { return ZERO;}
1  { return ONE;}
   

[\n"."]  {return yytext[0];}
[ \t]  {;}
.   {yyerror("invalid character");}

%%

int yywrap(void) {
    return 1;
}