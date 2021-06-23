%{
#include <stdio.h>
#include<stdlib.h>
#include<ctype.h>
void yyerror(char *);
int yylex(void);
int sym[52];
int symVal(char symbol);
int updateSymVal(char symbol, int val);
%}

%union {int num; char id;} 
%start line 
%token PRINT 
%token EXIT_COMMAND 
%token <num> NUMBER 
%token <id> ID 
%type <num> expr term 
%type <id> assignment 

%% 

line: 
        assignment ';' {;} 
        | EXIT_COMMAND ';' { exit(EXIT_SUCCESS); } 
        | PRINT expr ';' { printf("Value: %d\n", $2);}  
        | line assignment ';' {;} 
        | line EXIT_COMMAND ';' { exit(EXIT_SUCCESS);} 
        | line PRINT expr ';' { printf("Value: %d\n", $3); } 
        ;

assignment: 
        ID '=' expr { updateSymVal($1,$3); } 
        ;

expr: 
        term { $$ = $1; } 
        | expr '+' term { $$ = $1 + $3; } 
        | expr '-' term { $$ = $1 - $3; } 
        ;

term: 
        NUMBER { $$ = $1; }
        | ID { $$ = symVal($1); } 
        ;

%%

int computeSymIndex(char token) { 
    int index = -1; 
    if (islower(token)) 
        index = token - 'a' + 26; 
    else if (isupper(token)) 
        index = token - 'A';
    return index; 
} 

int symVal(char symbol) { 
    return sym[computeSymIndex(symbol)]; 
}

int updateSymVal(char symbol, int val){
    sym[computeSymIndex(symbol)] = val;
}

void yyerror(char *s){
    fprintf(stderr, "%s\n", s);
}

int main(void){
    int i;
    for(i = 0; i<52; i++)
        sym[i]=0;
    return yyparse();
}