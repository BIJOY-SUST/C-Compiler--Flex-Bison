
FLT [[:digit:]]+"."[[:digit:]]*

%option noyywrap

%%

[ \t\n]     ECHO;
{FLT}        fprintf(yyout, "FLT:%s[%d]",yytext,yyleng);
[^ \t\n]+   fprintf(yyout, "NOT_RECOGNIZED");

%%
int main(int argc, char *argv[])
    {
        yyin = fopen(argv[1],"r");
        yyout = fopen(argv[2],"w");
        yylex();
        return 0;
    }