/*
* Scanner for json
*/
%{
//declarations
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "json1.tab.h"
#define TK_ILLEGAL_SEQ 258
int i =0;
%}

%x COMMENT
%option noyywrap
%option yylineno
EXP           ([e][-+]?[0-9]+)

%%

"{"            {printf("LCURLY ");return LCURLY;}
"}"            {printf("RCURLY ");return RCURLY;}
"["            {printf("LBRACKET");return LBRACKET;}
"]"            {printf("RBRACKET");return RBRACKET;}
","            {printf("COMMA ");return COMMA;}
":"            {printf("COLON ");return COLON;}
"true"         {ECHO;}
"false"        {ECHO;}
"null"         {ECHO;}
"last"         {printf("last");return t_last;}
"active"       {printf("active");return t_active;}
"gameId"       {printf("gameId");return T_gameId;}
"drawId"       {printf("drawId");return T_drawId;}
"status"       {printf("status");return T_status;}
[ \t\r\n]+     { /* eat whitespace */ }
.              {return TK_ILLEGAL_SEQ;}

\"[^"]*\"             { printf("jsonString ");}
[1-9]+\.?[0-9]*{EXP}? { printf("jsonNumber ");}

%%

int main(int argc, char **argv)
{
yylex();
printf("FIN! %d",i);
return 0;
}
