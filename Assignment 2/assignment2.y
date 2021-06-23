%{
#include <stdio.h>
#include <math.h>
int yylex(void);
void yyerror(char *);
%}
%union{
    struct bin{
        float len;
        float val;
    }binary;
}

%token ONE ZERO
%start input
%type <binary> L NUM B 

%%
input:   %empty|input NUM  '\n';
NUM :     L '.' L {$$.val = $1.val + $3.val/pow(2,$3.len); printf("%f\n",$$.val);}
        | L {$$.val = $1.val; printf("%d\n", (int)$1.val);}
        ;
L :     L B {$$.val = ($1.val*2)+$2.val; $$.len = $1.len + 1;}
        | B {$$.val = $1.val; $$.len = 1;}
        ;
B :     ZERO {$$.val = 0; $$.len = 1;}
        | ONE {$$.val = 1; $$.len = 1;}
        ;
%%
void yyerror(char *s) { 
fprintf(stderr, "%s\n",s);
}

int main(void) {
    yyparse();
    return 0;
}