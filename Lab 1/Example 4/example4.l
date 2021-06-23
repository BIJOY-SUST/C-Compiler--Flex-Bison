

%{

#include <math.h>
int yywrap(void) {
	return 1;
}
%}

DIGIT    [0-9]
ID       [A-Za-z][A-Za-z0-9]*
EXP		 ([Ee](\+|\-)?{DIGIT}*)

%%

{DIGIT}+					{
								printf( "An integer: %s (%d)\n", yytext,
								atoi( yytext ) );
							}

{DIGIT}+"."{DIGIT}*			{
								printf( "A float: %s (%g)\n", yytext,
								atof( yytext ) );
							}

{DIGIT}+"."{DIGIT}*{EXP}			{
								printf( "A float with exponent: %s (%g)\n", yytext,
								atof( yytext ) );
							}

PROGRAM|program|if|then|begin|end|procedure|function|;|:|VAR|REAL|INTEGER|CHAR|STRING|BEGIN|"("|")"|"."|END {
								printf( "A keyword: %s\n", yytext );
							}

":="							printf("An operator: %s\n", yytext);

"'"[^}\n]*"'"				printf( "An string: %s\n", yytext );

{ID}							printf( "An identifier: %s\n", yytext );

"+"|"-"|"*"|"/"					printf( "An operator: %s\n", yytext );

"{"[^{}\n]*"}"					/* eat up one-line comments */

[ \t\n]+						/* eat up whitespace */

.								printf( "Unrecognized character: %s\n", yytext );

%%

int main( int argc, char **argv ) {

	
	++argv, --argc;  /* skip over program name */
	if ( argc > 0 )
		yyin = fopen( argv[0], "r" );
	else
		yyin = stdin;
	yylex();
	
}