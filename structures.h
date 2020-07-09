#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
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
    bool isarray = false;
    parameter * next_param = NULL;
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
    to_make = (char *)malloc(sizeof(char)*number_characters);
    strncpy(to_make, symbol, number_characters);
}

void term_factor(factor factor, term term)
{

}

void term_make_complete(term term, char * operator, factor factor, term term)
{

}

void addi_exp_term(term term, addi_exp exp)
{

}

void addi_exp_op(addi_exp exp_make, char * op, term term, addi_exp exp)
{

}

void simple_add(addi_exp exp, simple_exp s_exp)
{

}

void simple_add_two_exp(addi_exp exp, char op, addi_exp exp2, simple_exp s_exp)
{

}

void make_var_array(char * identifier, expr_str  expression, var var)
{

}

void make_var(char * identifier, var var)
{

}

void expr_simple(simple_exp  s_exp, expr_str expression)
{

}

void expr_var_exp(var var, expr_str expression, expr_str expression_final)
{

}

void return_expr(expr_str expression, return_str return_st)
{

}

void return_end(return_str return_st)
{

}

void make_while_stmt(expr_str expression, statement_str statement, inter_stmt iteration)
{

}

void make_sel_if_else_stmt(expr_str expression, statement_str statement_if, statement_str statement_else, select_stmt select)
{

}

void make_sel_if(expr_str expression, statement_str statement_if, selec_stmt select)
{

}

void expression_end(expr_stmt expre)
{

}

void make_expression(expr_str expression ,expr_stmt expre)
{

}

void statement_return(retunr_str ret, stmt_str statement)
{

}

void statement_itera(inter_stmt iteration, stmt_str statement)
{

}

void statement_select(selec_stmt select, stmt_str statement)
{

}

void statement_comp(compound_st compt, stmt_str statement)
{

}

void statement_expr(expr_stmt expr, stmt_str statement)
{

}

void make_statement_list(stmt_list stmt, stmt_str state, stmt_list stmt_final)
{

}

void make_local_declaration(local_dec local, var_decl var_dec, local_dec local_end )
{

}

void make_compound_stmt(local_dec local, stmt_list stmt_ls, compound_st final)
{

}

void create_param(char * type_s, char * identifier, bool is_array, parameter * param)
{
    param = ( parameter*)malloc(sizeof(parameter));
    param->local_identifier = identifier;
    param->type = type_s;
    param->isarray = is_array;
    param->next_param = NULL;
}

void add_last_param(parameter * param, parameter * parameters)
{
    parameters = param;
}

void add_param(parameter * paramenter, parameter * param, parameter * parameter_end)
{
    parameter_end = paramenter;
    paramenter->next_param = param;
}

void create_fun_dec(char * types, char * identifier, parameter paramenters, compound_st comp_st)
{

}

void create_var_array_dec(char * types, char * identifier, int array_size, var varialbe)
{

}

void create_var_dec(char * types, char * identifier, var varialbe)
{

}

