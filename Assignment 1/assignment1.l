%{
#include "y.tab.h"
%}
%option noyywrap
%%

float       return fType;

int         return iType;

[a-zA-Z]   {
            yylval = yytext[0];
            return ID;
        }

[;,\n]    {return yytext[0];}
    
[ \t]   /* */ 

.   

%%
