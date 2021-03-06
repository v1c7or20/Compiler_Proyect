#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct 
{
    char * local_identifier = NULL;
    char * type = NULL;
    bool isarray = false;
    parameter * next_param = NULL;
}parameter;

typedef struct 
{
    char * identifier = NULL;
    char * type = NULL;
    bool is_funtion = NULL;
    parameter * fun_parameters = NULL;
    int array_size;
    table * inside = NULL;
}row;

typedef struct 
{
    int actual = 0;
    row rows_simbol [100];

}table;

typedef struct 
{
    char * identifier = NULL;
    char * type = NULL;
    int size;
    var_list * next = NULL;
} var_list;

typedef struct 
{
    char * identifier = NULL;
    expression * var_exp = NULL;
    bool is_array = false; 
    expression * assinged = NULL;
    expression * operators = NULL;
    char * relop = NULL;
    char types;
}expression;


typedef struct 
{   
    statement * if_iter_stmt = NULL;
    statement * else_stmt = NULL;
    expression * expr = NULL;
    char types;
    statement * next = NULL;
}statement;

typedef struct
{
    statement * begin = NULL;
    var_list * inside = NULL;
} compound;

typedef struct 
{
    char * types = NULL;
    char * identifier = NULL;
    parameter * param = NULL;
    compound * comp = NULL;
}funtion_dec;

typedef struct 
{
    bool is_funtion;
    var_list * variable = NULL;
    funtion_dec * function = NULL;
    declaration_str * next_node = NULL;    
}declaration_str;

typedef struct
{
    char * identifier = NULL;
    bool is_array = false;
    expression * expr;
}var_pass;


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

void addi_exp_op(addi_exp exp_make, char * op, term term, expression exp)
{

}

void simple_add(expression * exp, expression * s_exp)
{
    s_exp->operators = (expression *)malloc(sizeof(expression));
    s_exp->operators[0] = exp;
    s_exp->types = 'C';
}

void simple_add_comp_exp(expression * exp, char * relop, expression * exp2, expression * s_exp)
{
    s_exp->operators = (expression *)malloc(sizeof(expression)*2);
    s_exp->operators[0] = exp;
    s_exp->operators[1] = exp2;
    s_exp->relop = relop;
    s_exp->types = 'C';
}

void make_var_array(char * identifier, expression * expr, var_pass * var)
{
    make_char(64, identifier, var->identifier);
    var->expr = expr;
    var->is_array = true;
}

void make_var(char * identifier, var_pass * var)
{
    var->is_array = false;
    make_char(64, identifier, var->identifier);
    
}

void expr_simple(expression *  s_exp, expression * expr)
{
    expr = s_exp;
}

void expr_var_exp(var_pass * var, expression * expre, expression * expression_final)
{
    expression_final->identifier = var->identifier;
    expression_final->var_exp = var->expr;
    expression_final->is_array = var->is_array;
    expression_final->assinged = expre;
    expression_final->types = 'V';
}

void return_expr(expression * expression, statement * return_st)
{
    return_st->expr = expression;
    return_st->next = NULL;
}

void return_end(statement * return_st)
{
    return_st->next = NULL;
}

void make_while_stmt(expression * expression, statement * state, statement * iteration)
{
    iteration->if_iter_stmt = state;
    iteration->expr = expression;
}

void make_sel_if_else_stmt(expression * expression, statement * statement_if, statement * statement_else, statement * select)
{
    select->expr = expression;
    select->if_iter_stmt = statement_if;
    select->else_stmt = statement_else;
}

void make_sel_if(expression * expr, statement * statement_if, statement * select)
{
    select->expr = expr;
    select->if_iter_stmt = statement_if;
}

void expression_end(statement * expre)
{
    expre->expr = NULL;
}

void make_expression(expression * expre ,statement * expre_stmt)
{
    expre_stmt->expr = expre;
}

void statement_return(statement * ret, statement * statement)
{
    statement = ret;
    statement->types = 'R';
}

void statement_itera(statement * iteration, statement * statement)
{
    statement = iteration;
    statement->types = 'I';
}

void statement_select(statement * select, statement * statement)
{
    statement = select;
    statement->types = 'S';
}

void statement_comp(statement * compt, statement * statement)
{
    statement = compt;
    statement->types = 'C';
}

void statement_expr(statement * expr, statement * statement)
{
    statement = expr;
    statement->types = 'E';
}

void make_statement_list(statement * stmt, statement * state, statement * stmt_final)
{
    stmt_final = stmt;
    stmt->next = state;
}

void make_last_statement(statement * last)
{
    if (last->next != NULL and last != NULL)
    {
        last = last->next;
    }
}

void make_local_declaration(var_list * local_dec, var_list * var_dec, var_list * local_end )
{
    local_end = local_dec;
    local_dec->next = var_dec;
}

void last_var_dec(var_list * last)
{
if (last->next != NULL and last != NULL)
    {
        last = last->next;
    }
}

void make_compound_stmt(var_list * local, statement * stmt_ls, compound * final)
{
    final->inside = local;
    final->begin = stmt_ls;
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
//revisar
void create_fun_dec(char * types, char * identifier, parameter * paramenters, compound * stmt ,funtion_dec * variable)
{
    variable->comp = stmt;
    variable->identifier = identifier;
    variable->param = paramenters;
    variable->types = types;
}

void create_var_array_dec(char * types, char * identifier, int array_size, var_list * variable)
{
    variable = (var_list *)malloc(sizeof(var_list));
    variable->identifier = identifier;
    variable->size = array_size;
    variable->type = types;
}

void create_var_dec(char * types, char * identifier, var_list * variable)
{
    variable = (var_list *)malloc(sizeof(var_list));
    variable->identifier = identifier;
    variable->size = 0;
    variable->type = types;
}

void add_data_fun(funtion_dec * funct, declaration_str * dec)
{
    dec->is_funtion = true;
    dec->function = funct;
    dec->variable = NULL;
}

void add_fun()
{

}
void add_data_var(var_list * variable, declaration_str * dec)
{
    dec->is_funtion = false;
    dec->variable = variable;
    dec->function = NULL;
}

void add_var()
{

}

void new_branch(declaration_str * dec, int number)
{
    dec = (declaration_str *)malloc(sizeof(declaration_str)*number);
}