%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

extern FILE* yyin;
extern int yylex(void);
extern void yyterminate();
int linenum = 0;
%}

%token NUMERO 
%token MUL ADD SUB  L_BRACKET R_BRACKET EOL
%%
program:  |
		program command			;

command: EOL { printf("Please enter a calculation:\n"); }
		|exp EOL {printf("%d\n", $1); linenum++;}
        ;
exp:    exp ADD term { $$ = $1 + $3; } |
        exp SUB term { $$ = $1 - $3; } | 
        term { $$ = $1; }
        ;
term:   term MUL factor { $$ = $1 * $3; }| factor {$$ = $1;}
        ;
factor: L_BRACKET exp R_BRACKET { $$ = $2; } | NUMERO { $$ = $1; }
        ;

%%

main ()
{
        char* c;

	yyin = fopen("prueba.txt", "r");
	if (!yyin) {
		printf("ERROR: Couldn't open file %s\n", c);
		printf("Error %d \n", errno);
		exit(-1);
	}
	yyparse();
		
	printf("All done with %s\n", "prueba.txt");
}



void yyerror(char *s)
{	
	printf("Error in line %d\n", linenum);
    fprintf(stderr, "%s\n", s);
}