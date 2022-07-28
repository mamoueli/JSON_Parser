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
"{"            {printf("%s ", yytext); return LCURLY;}
"}"            {printf("%s ", yytext); return RCURLY;}
"["            {printf("%s ", yytext); return LBRACKET;}
"]"            {printf("%s ", yytext); return RBRACKET;}
","            {printf("%s ", yytext); return COMMA;}
":"            {printf("%s ", yytext); return COLON;}
"true"         {ECHO;}
"false"        {ECHO;}
"null"         {ECHO;}
[ \t\r\n]+     { /* eat whitespace */ }
\"[^"]*\"             { printf("jsonString "); return jsonString;}
[1-9]+\.?[0-9]*{EXP}? { printf("jsonNumber "); return jsonNumber;}\

"gameId"           {printf("%s ", yytext); return T_gameId;}
"drawId"           {printf("%s ", yytext); return T_drawId;}
"drawtime"         {printf("%s ", yytext); return T_drawtime;}
"status"           {printf("%s", yytext); return T_status;}
"drawbreak"        {printf("%s", yytext); return T_drawbreak;}
"visualdraw"       {printf("%s", yytext); return T_visualdraw;}

"pricepoints"      {printf("%s ", yytext); return T_pricepoints;}
"amount"           {printf("%s ", yytext); return T_amount;}
"winningnumbers"   {printf("%s ", yytext); return T_winningnumbers;}
"list"             {printf("%s ", yytext); return T_list;}
"bonus"            {printf("%s ", yytext); return T_bonus;}
"prizecat"         {printf("%s ", yytext); return T_prizecat;}
"wagerstatistics"  {printf("%s ", yytext); return T_wagerstatistics;}

"columns"          {printf("%s ", yytext); return T_columns;}
"wagers"           {printf("%s ", yytext); return T_wagers;}
"addon"            {printf("%s ", yytext); return T_addon;}

%%

/*int main(int argc, char **argv)
{
yylex();
printf("FIN! %d",i);
return 0;
}*/
