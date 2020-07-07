%{
#include "y.tab.h"
int yylex();
%}
%option noyywrap

number [0-9]+
word [a-zA-Z]+

%%

"if"            { return IF_CLAUSE;}
"else"          { return ELSE_CLAUSE;}
"int"           { return INT_IDENTIFIER;}
"void"          { return VOID_IDENTIDIER;}
"while"         { return WHILE_CLAUSE;}
"return"        { return RETURN;}
"+"             { return ADD; }
"-"             { return SUB; }
"*"             { return MUL; }
"/"             { return DIV; }
"<"             { return LESS_THAN; }
"<="            { return LESS_OR_EQUAL; }
">"             { return MORE_THAN; }
">="            { return MORE OR EQUAL; }
"=="            { return EQUAL; }
"!="            { return DIFFERENT; }
"="             { return ASSING; }
";"             { return END_SENTENCE; }
","             { return COLON; }
"("				{ return LEFT_PARENTHESIS; }
")"				{ return RIGHT_PARENTHESIS; }
"["             { return LEFT_BRACKET; }
"]"             { return RIGHT_BRACKET; }
"{"             { return LEFT_CURLY_BRACKET; }
"}"             { return RIGHT_CURLY_BRACKET; }
"/*"            { return START_COMMENT; }
"*/"            { return END_COMMENT; }
{number}        {yylval = atoi(yytext); return NUMBER;}
{word}          {yylval = yytext; return IDENTIFIER;}
[\n]            { return EOL; }
[ \t]                ;
.       ;

%%
