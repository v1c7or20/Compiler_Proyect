#include <stdio.h>
#include <stdbool.h>

typedef struct 
{
    tree_node next_node;
    char * clause;
    
}tree_node;


typedef struct 
{
    char * local_identifier;
    char * type;
}parameter;

typedef struct 
{
    char * identifier;
    char * type;
    bool is_funtion;
    int param_num;
    parameter * fun_parameters;
    int array_size;
}row;

typedef struct 
{
    row rows_simbol [200];

}table;

void add_arg_exp(expr_str struct_data, arg_str arguments )
{

}

void add_arg(arg_str arg_slave, arg_str arg_master)
{

}

void make_call(char * identifier, arg_str arguments, call call) 
{

}

void factor_number(int number, factor factor)
{

}

void factor_call(call call, factor factor)
{

}

void factor_var(var var, factor factor)
{

}

void factor_expresion(expr_str expression, factor factor)
{

}

void make_char(int number_characters, char * symbol, char * to_make)
{

}

void term_factor(factor factor, term term)
{

}

void term_make_complete(term term, char * operator, factor factor, term term)
{

}

