/* Reverse Polish Notation calculator */
%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int yylex(void);
void yyerror (char const *);
%}
%define api.value.type {double}
%token NUM

%%

input:
        %empty
        | input line
        ;

line:
        '\n'
        | exp '\n' {printf("%.10g\n", $1);}
        ;

exp:
        NUM
        | exp exp '+' {$$ = $1 + $2 ;}
        | exp exp '-' {$$ = $1 - $2 ;}
        | exp exp '*' {$$ = $1 * $2 ;}
        | exp exp '/' {$$ = $1 / $2 ;}
        | exp exp '^' {$$ = pow($1, $2) ;} /* exponentiation */
        | exp 'n' {$$ = -$1 ;}              /* unary minus */
        ;

%%

void yyerror(char const *s){
    fprintf(stderr, "%s\n",s);
}

int  yylex (void){
    int c = getchar();
    /*skip white space*/
    while(c == ' ' || c == '\t')
        c = getchar();
    /* Process numbers. */
    if (c == '.' || isdigit(c)){
        ungetc (c, stdin);
        if(scanf("%lf", &yylval) != 1)
            abort();
        return NUM;
    }
    /* Return end-of-input */
    else if(c == EOF)
        return YYEOF;
    /* Return a single char */
    else   
        return c;
}

int main(void){
    return yyparse();
}