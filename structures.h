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
