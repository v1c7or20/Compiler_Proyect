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
						new_branch($$,2);					//create the nodes to start, $$ is root
						$$->leaves[0] = $1;
						$$->leaves[1] = $2;		
					}
                |   declaration
					{
						new_branch($$,1)					//last declaration of a leave
						$$->leaves[0] = $1;
					}        
                    ;
declaration:        var_declaration
                    {
						add_var(symbol_table, $1);			//add to the symbol_table the variable
						add_data_var($1,$$);					//add the data to the node declaration
                    }
                |   fun_declaration
                    {
						add_fun(symbol_table, $1);			//add to the symbol_table the funtion
						add_data_fun($1,$$);					//add data to the node declaration
                    }
        ;
var_declaration:    type_specifier IDENTIFIER END_SENTENCE
                    {
						create_var_dec($1,$2,$$);			//create a struture to use this data in var_declaration
                    }
                |   type_specifier IDENTIFIER RIGHT_BRACKET NUMBER LEFT_BRACKET END_SENTENCE
                    {
						create_var_array_dec($1,$2,$4,$$);	//create struture with the number in the array
                    }
                |   error END_SENTENCE
                    {
						printf("error en al declaracion de variable:");
                    }
        ;
type_specifier:     INT_IDENTIFIER
					{
						make_char(4,"int",$$);							//copy or points to the data of the identifier, can be change for strncpy
					}
                |   VOID_IDENTIFIER
					{
						make_char(6,"void",$$);
					}
        ;
fun_declaration:    type_specifier IDENTIFIER RIGHT_PARENTHESIS params LEFT_PARENTHESIS compound_stmt
					{
						create_fun_dec($1,$2,$4,$6,$$);		//create data struture of the funtion to pass the data
						//funcion for data compond_stmt
					}
        ;
params:             params_list
					{
						$$ = $1;							//$$ and $1 must be char ** in order to have an array of strings of parameters
					}
                |   VOID_IDENTIFIER
					{
						$$ = NULL;							//if void, $$ is NULL, must control this case in the creation of params in create_fun_dec
					}
        ;
params_list:        params_list COLON param
					{
						add_param($1,$3,$$);				//adds to $$ the parameters of the other two
					}
                |   param
					{
						add_last_param($1, $$);				//add the last parameter, careful in initialization
					}
        ;
param:              type_specifier IDENTIFIER
					{
						create_param($1,$2,false,$$);				//create a struture to save data to pass
					}
                |   type_specifier IDENTIFIER RIGHT_BRACKET LEFT_BRACKET
					{
						create_param($1,$2,true,$$);				//create a struture to save data to pass
					}
        ;
compound_stmt:      LEFT_CURLY_BRACKET local_declarations statement_list RIGHT_CURLY_BRACKETS
					{
						make_compound_stmt($2,$3,$$);
					}
        ;
local_declarations: local_declarations var_declaration
					{
						make_local_declaration($1,$2,$$);
					}
                |   
					{
						last_var_dec($$);
					}
        ;
statement_list:     statement_list statement
					{
						make_statement_list($1,$2,$$);
					}
                |   
					{
						make_last_statement($$);
					}
        ;
statement:          expression_stmt
					{
						statement_expr($1,$$);
					}
                |   compound_stmt
					{
						statement_comp($1,$$);
					}
                |   selection_stmt
					{
						statement_selec($1,$$);
					}
                |   iteration_stmt
					{
						statement_itera($1,$$);
					}
                |   return_stmt
					{
						statement_return($1,$$);
					}
        ;
expression_stmt:    expression END_SENTENCE
					{
						make_expression($1,$$);
					}
                |   END_SENTENCE
					{
						expression_end($$);
					}
                |   error END_SENTENCE
					{
						printf("error in expresion");
					}
        ;
selection_stmt:     IF_CLAUSE RIGHT_PARENTHESIS expression LEFT_PARENTHESIS statement
					{
						make_sel_if($3,$5,$$);
					}
                |   IF_CLAUSE RIGHT_CURLY_BRACKETS expression LEFT_PARENTHESIS statement ELSE_CLAUSE statement
					{
						make_sel_if_else_stmt($3,$5,$7,$$);
					}
        ;
iteration_stmt:     WHILE_CLAUSE LEFT_PARENTHESIS expression RIGHT_PARENTHESIS statement
					{
						make_while_stmt($3,$5,$$);
					}
        ;
return_stmt:        RETURN END_SENTENCE
					{
						return_end($$);
					}
                |   RETURN expression END_SENTENCE
					{
						return_expr($2.$$);
					}
                |   error END_SENTENCE
					{
						printf("Error in return statement");
					}
        ;
expression:         var ASSING expression
					{
						exp_var_exp($1,$3,$$);
					}
                |   simple_expression
					{
						expr_simple($1,$$);
					}
        ;
var:                IDENTIFIER
					{
						make_var($1,$2);
					}
                |   IDENTIFIER LEFT_BRACKET expression RIGHT_BRACKET
					{
						make_var_array($1,$3,$$);
					}
        ;
simple_expression:  additive_expression relop additive_expression
					{
						simple_add_two_exp($1,$2,$3,$$);
					}
                |   additive_expression
					{
						simple_add($1,$$);
					}
        ;
relop:              LESS_OR_EQUAL
					{
						make_char(3,"<=",$$);
					}
                |   LESS_THAN
					{
						make_char(2,"<",$$);
					}
                |   MORE_THAN
					{
						make_char(2,">",$$);
					}
                |   MORE_OR_EQUAL
					{
						make_char(3,">=",$$);
					}
                |   EQUAL
					{
						make_char(3,'==',$$);	
					}
                |   DIFFERENT
					{
						make_char(4,'!=',$$);
					}
        ;
additive_expression:additive_expression addop term 
					{
						addi_exp_op($1,$2,$3,$$);
					}
                |   term
					{
						addi_exp_term($1,$$);
					}
        ;
addop:              ADD
					{
						make_char(2,'+';$$);
					}
                |   SUB
					{
						make_char(2,'-',$$);
					}
        ;
term:               term mulop factor
					{
						term_make_complete($1,$2,$3,$$);
					}
                |   factor
					{
						term_factor($1,$$);
					}
        ;
mulop:              MUL
					{
						make_char(2,'*',$$);
					}
                |   DIV
					{
						make_char(2,'/',$$);
					}
        ;
factor:             LEFT_PARENTHESIS expression RIGHT_PARENTHESIS
					{
						factor_expresion($2,$$);
					}
                |   var
					{
						factor_var($1,$$);
					}
                |   call
					{
						factor_call($1,$$);
					}
                |   NUMBER
					{
						factor_number($1,$$);
					}
        ;
call:               IDENTIFIER LEFT_PARENTHESIS args RIGHT_PARENTHESIS
                    {
						make_call($1,$3,$$);
                    }
        ;
args:               arg_list
                    {
						add_arg($1,$$);
                    }
                |   
                    {
						;
                    }
        ;
arg_list:           arg_list COLON expression
                    {
						add_arg_exp($3,$$);
						add_arg($1,$$);
                    }
                |   expression
                    {
						add_arg_exp($1,$$)
                    }
        ;

%%


main ()
{
        char* c;

	yyin = fopen("prueba.txt", "r");
	if (!yyin) {e
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