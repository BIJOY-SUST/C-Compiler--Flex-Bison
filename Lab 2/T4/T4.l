
%{
    char *str;
    #include <string.h>
%}

%option noyywrap
    
%%

\"[^"\n]*["\n] {
    str = strdup(yytext+1);
    if (str[yyleng-2] != '"')
        printf("Improperly terminated string.");
    else
        str[yyleng-2] = '\0'; 
    
    printf("Found '%s'", str);
    //printf("Length #d\n", yyleng);
}

%%
int main(int argc, char *argv[])
    {
        //yyin = fopen(argv[1],"r");
        yylex();
        fclose(yyin);
    }