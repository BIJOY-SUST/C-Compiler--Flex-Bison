%{

#include "y.tab.h"

%}

%option noyywrap
    
%%
"exit" {return EXIT_COMMAND;}
"print" {return PRINT;}

    /* variables */
[a-zA-Z]   {
            yylval.id = yytext[0];
            return ID;
        }

    /* integers */
[0-9]+   {
            yylval.num = atoi(yytext);
            return NUMBER;
        }

    /* operators */
[+-=;]   {
                    return yytext[0];
                }

    
[ \t\n]   /* skip whitespaces */ 

    /* undefined */
.   {
        ECHO;
        yyerror("invalid character");
    }



%%
