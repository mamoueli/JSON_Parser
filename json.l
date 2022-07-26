/*
* Scanner for json
*/
%{
//declarations
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define TK_ILLEGAL_SEQ 258
int i =0;
%}

%x COMMENT
%option noyywrap
%option yylineno
EXP            ([e][-+]?[0-9]+)

%%

"{"            {printf("LCURLY ");}
"}"            {printf("RCURLY ");}
"["            {printf("LBRACKET");}
"]"            {printf("RBRACKET");}
","            {printf("COMMA ");}
":"            {printf("COLON ");}
"true"         {ECHO;}
"false"        {ECHO;}
"null"         {ECHO;}
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
