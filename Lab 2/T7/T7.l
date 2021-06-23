
ID [[:alpha:]_][[:alnum:]_]*

%option noyywrap

%%

[ \t\n]     ECHO;
{ID}        fprintf(stdout, "ID:%s[%d]",yytext,yyleng);
[^ \t\n]+   fprintf(stdout, "NOT_RECOGNIZED");

%%
int main(int argc, char *argv[])
    {
        yyin = fopen(argv[1],"r");
        yyout = fopen(argv[2],"w");
        yylex();
        return 0;
    }