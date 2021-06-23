
%{
    int countA = 0, countB=0, countC=0;;
%}

%option noyywrap
%option yylineno
    
%%

^\n fprintf(yyout, "%4d\n", yylineno-1);
a   countA++;
b   countB++;
c   countC++;
.   ;
\n  {
        fprintf(yyout, "%4d\tA:%4d\tB:%4d\tC:%4d\n", yylineno-1, countA,countB,countC);
        countA = 0;
        countB = 0;
        countC = 0;
    }
<<EOF>> {
    fprintf(yyout, "%4d\tA:%4d\tB:%4d\tC:%4d\n", yylineno, countA,countB,countC);
    yyterminate();
}


%%
int main(int argc, char *argv[])
    {
        yyin = fopen(argv[1],"r");
        yyout = fopen(argv[2],"w");
        yylex();
        fclose(yyin);
        fclose(yyout);
    }