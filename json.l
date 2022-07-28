/*
* Scanner for json
*/
%{
//declarations
#include "json1.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern void yyerror(const char * message);
int i =0;
%}

%x COMMENT
%option noyywrap
%option yylineno

EXP            ([e][-+]?[0-9]+)

%%
"{"            {printf("LCURLY "); return LCURLY;}
"}"            {printf("RCURLY "); return RCURLY;}
"["            {printf("LBRACKET"); return LBRACKET;}
"]"            {printf("RBRACKET"); return RBRACKET;}
","            {printf("COMMA "); return COMMA;}
":"            {printf("COLON "); return COLON;}
"true"         {ECHO;}
"false"        {ECHO;}
"null"         {ECHO;}
[ \t\r\n]+     { /* eat whitespace */ }
\"[^"]*\"             { printf("jsonString "); return jsonString;}
[1-9]+\.?[0-9]*{EXP}? { printf("jsonNumber "); return jsonNumber;}

%%

/*int main(int argc, char **argv)
{
yylex();
printf("FIN! %d",i);
return 0;
}*/
