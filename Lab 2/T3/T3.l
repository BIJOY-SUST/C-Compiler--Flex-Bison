
%{
    int lineno = 0;
%}

%option noyywrap
    
%%

^(.*)\n printf("%4d\t%4d\t%s", ++lineno, yyleng-1, yytext);

%%
int main(int argc, char *argv[])
    {
        //yyin = fopen(argv[1],"r");
        yylex();
        fclose(yyin);
    }