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

%token NUMBER 
%token MUL ADD SUB  L_BRACKET R_BRACKET EOL
%%

program:            declaration_list			;

declaration_list:   declaration_list declaration
                |   declaration               
                    ;
declaration:        var_declaration
                |   fun_declaration
        ;
var_declaration:    type_specifier IDENTIFIER END_SENTENCE
                |   type_specifier IDENTIFIER RIGHT_BRACKET NUMBER LEFT_BRACKET END_SENTENCE
        ;
type_specifier:     INT_IDENTIFIER
                |   VOID_IDENTIFIER
        ;
fun_declaration:    type_specifier IDENTIFIER RIGHT_PARENTHESIS params LEFT_PARENTHESIS compound_stmt
        ;
params:             params_list
                |   VOID_IDENTIFIER
        ;
params_list:        params_list COLON param 
                |   param
        ;
param:              type_specifier IDENTIFIER
                |   type_specifier IDENTIFIER RIGHT_BRACKET LEFT_BRACKET
        ;
compound_stmt:      

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