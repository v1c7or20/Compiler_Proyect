%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include "structures.h"

table symbol_table;
extern FILE* yyin;
extern int yylex(void);
extern void yyterminate();
int linenum = 0;
%}

%union {
    int iValue;
	            
};

%token <iValue> NUMBER 
%token IF_CLAUSE ELSE_CLAUSE INT_IDENTIFIER VOID_IDENTIFIER WHILE_CLAUSE RETURN
%token MUL ADD SUB DIV LESS_THAN LESS_OR_EQUAL MORE_THAN MORE_OR_EQUAL EQUAL DIFFERENT
%token ASSING END_SENTENCE COLON
%token LEFT_PARENTHESIS RIGHT_PARENTHESIS LEFT_BRACKET RIGHT_BRACKET LEFT_CURLY_BRACKET RIGHT_CURLY_BRACKETS 



%%

program:            declaration_list
					{
						
					}
		;

declaration_list:   declaration_list declaration
					{
						$$ = newBranch();
						$$->leaves[0] = $1;
						$$->leaves[1] = $2;
					}
                |   declaration
					{
						$$ = newLeave();
						$$->leaves = $1;
					}        
                    ;
declaration:        var_declaration
                    {
						add_var(symbol_table, $1);
						add_data($$,$1);
                    }
                |   fun_declaration
                    {
						add_fun(symbol_table, $1);
						add_data($$,$1);
                    }
        ;
var_declaration:    type_specifier IDENTIFIER END_SENTENCE
                    {
						create_var_dec($1,$2,$$);
                    }
                |   type_specifier IDENTIFIER RIGHT_BRACKET NUMBER LEFT_BRACKET END_SENTENCE
                    {
						create_var_array_dec($1,$2,$4,$$);
                    }
                |   error END_SENTENCE
                    {
						printf("error en al declaracion de variable:");
                    }
        ;
type_specifier:     INT_IDENTIFIER
					{
						$$ = $1;
					}
                |   VOID_IDENTIFIER
					{
						$$ = $1;
					}
        ;
fun_declaration:    type_specifier IDENTIFIER RIGHT_PARENTHESIS params LEFT_PARENTHESIS compound_stmt
					{
						create_fun_dec($1,$2,$4);
					}
        ;
params:             params_list
					{
						
					}
                |   VOID_IDENTIFIER
					{
						
					}
        ;
params_list:        params_list COLON param
					{

					}
                |   param
					{

					}
        ;
param:              type_specifier IDENTIFIER
					{

					}
                |   type_specifier IDENTIFIER RIGHT_BRACKET LEFT_BRACKET
					{

					}
        ;
compound_stmt:      LEFT_CURLY_BRACKET local_declarations statement_list RIGHT_CURLY_BRACKETS
					{

					}
        ;
local_declarations: local_declarations var_declaration
					{

					}
                |   EMPTY
					{

					}
        ;
statement_list:     statement_list statement
					{

					}
                |   EMPTY
					{

					}
        ;
statement:          expression_stmt
					{

					}
                |   compound_stmt
					{

					}
                |   selection_stmt
					{

					}
                |   iteration_stmt
					{

					}
                |   return_stmt
					{

					}
        ;
expression_stmt:    expression END_SENTENCE
					{

					}
                |   END_SENTENCE
					{

					}
                |   error END_SENTENCE
					{

					}
        ;
selection_stmt:     IF_CLAUSE RIGHT_PARENTHESIS expression LEFT_PARENTHESIS statement
					{

					}
                |   IF_CLAUSE RIGHT_CURLY_BRACKETS expression LEFT_PARENTHESIS statement ELSE_CLAUSE statement
					{

					}
        ;
iteration_stmt:     WHILE_CLAUSE LEFT_PARENTHESIS expression RIGHT_PARENTHESIS statement
					{

					}
        ;
return_stmt:        RETURN END_SENTENCE
					{

					}
                |   RETURN expression END_SENTENCE
					{

					}
                |   error END_SENTENCE
					{

					}
        ;
expression:         var ASSING expression
					{

					}
                |   simple_expression
					{

					}
        ;
var:                IDENTIFIER
					{

					}
                |   IDENTIFIER LEFT_BRACKET expression RIGHT_BRACKET
					{

					}
        ;
simple_expression:  additive_expression relop additive_expression
					{

					}
                |   additive_expression
					{

					}
        ;
relop:              LESS_OR_EQUAL
					{

					}
                |   LESS_THAN
					{

					}
                |   MORE_THAN
					{

					}
                |   MORE_OR_EQUAL
					{

					}
                |   EQUAL
					{

					}
                |   DIFFERENT
					{

					}
        ;
additive_expression:additive_expression addop term 
					{

					}
                |   term
					{

					}
        ;
addop:              ADD
					{

					}
                |   SUB
					{

					}
        ;
term:               term mulop factor
					{

					}
                |   factor
					{

					}
        ;
mulop:              MUL
					{

					}
                |   DIV
					{

					}
        ;
factor:             LEFT_PARENTHESIS expression RIGHT_PARENTHESIS
					{

					}
                |   var
					{

					}
                |   call
					{

					}
                |   NUMBER
					{
						$$->
					}
        ;
call:               IDENTIFIER LEFT_PARENTHESIS args RIGHT_PARENTHESIS
                    {

                    }
        ;
args:               arg_list
                    {

                    }
                |   EMPTY
                    {

                    }
        ;
arg_list:           arg_list COLON expression
                    {

                    }
                |   expression
                    {

                    }
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