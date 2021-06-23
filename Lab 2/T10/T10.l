

%{

#include <math.h>
int yywrap(void) {
	return 1;
}
%}

%option case-insensitive
DIGIT    [0-9]
ID       [A-Za-z][A-Za-z0-9]*
EXP		 ([Ee](\+|\-)?{DIGIT}*)

%%

{DIGIT}+					{
								fprintf(yyout, "An integer: %s (%d)\n", yytext,
								atoi( yytext ) );
							}

{DIGIT}+"."{DIGIT}*			{
								fprintf(yyout, "A float: %s (%g)\n", yytext,
								atof( yytext ) );
							}

{DIGIT}+"."{DIGIT}*{EXP}			{
								fprintf(yyout, "A float with exponent: %s (%g)\n", yytext,
								atof( yytext ) );
							}

PROGRAM|program|if|then|begin|end|procedure|function|;|:|VAR|REAL|INTEGER|CHAR|STRING|BEGIN|"("|")"|"."|END {
								fprintf(yyout, "A keyword: %s\n", yytext );
							}

":="							fprintf(yyout, "An operator: %s\n", yytext);

"'"[^}\n]*"'"				fprintf(yyout, "An string: %s\n", yytext );

{ID}							fprintf(yyout, "An identifier: %s\n", yytext );

"+"|"-"|"*"|"/"					fprintf(yyout, "An operator: %s\n", yytext );

"{"[^{}\n]*"}"					/* eat up one-line comments */

[ \t\n]+						/* eat up whitespace */

.								fprintf(yyout, "Unrecognized character: %s\n", yytext );

%%

int main( int argc, char **argv ) {

	
	++argv, --argc;  /* skip over program name */
	if ( argc > 1 ){
		yyin = fopen( argv[0], "r" );
		yyout = fopen( argv[1], "w" );
	}
	else if ( argc > 0 ){
		yyin = fopen( argv[0], "r" );
	}
	else{
		yyin = stdin;
	}
	yylex();
	
}