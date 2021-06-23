%{
#include <stdio.h>
#include <math.h>
int yylex(void);
void yyerror(char *);
int flag=0; 
%}

%token fType iType
%token  ID
%start S

%%
S:  S X '\n' {printf("\n");}
        |
        ;

X:      X ';' X
        |   t variable   
        ;

t:   fType   {flag = 1;}
        | iType   {flag = 0;}
        ;

variable:     variable ',' variable
        | ID    {
                    if( flag == 1)printf("%c(float), ", $1);
                    else    printf("%c(int), ", $1);
                }
        ;   
%%

void yyerror(char *s) {
fprintf(stderr, "%s\n",s);
}

int main(void) {
yyparse();
return 0;
}
