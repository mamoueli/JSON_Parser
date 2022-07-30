/*
* Scanner for json
*/
%{
//declarations
#include "bisonparser.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern void yyerror(const char * message);
int i =0;
%}

%option noyywrap
%option yylineno

EXP            ([e][-+]?[0-9]+)

%%
"{"                     {printf("%s ", yytext); return LCURLY;}
"}"                     {printf("%s ", yytext); return RCURLY;}
"["                     {printf("%s ", yytext); return LBRACKET;}
"]"                     {printf("%s ", yytext); return RBRACKET;}
","                     {printf("%s ", yytext); return COMMA;}
":"                     {printf("%s ", yytext); return COLON;}
"true"                  {ECHO;}
"false"                 {ECHO;}
"null"                  {ECHO;}
[ \t\r\n]+              { /* eat whitespace */ }

\"[^"]*\"               { printf("jsonString "); return jsonString;}

[1-9]+\.?[0-9]*{EXP}?   { printf("jsonNumber "); return jsonNumber;}

"last"                  {printf("%s ", yytext); return T_last;}
"active"                {printf("%s ", yytext); return T_active;}

"gameId"                {printf("%s ", yytext); return T_gameId;}
"drawId"                {printf("%s ", yytext); return T_drawId;}
"drawTime"              {printf("%s ", yytext); return T_drawTime;}
"status"                {printf("%s", yytext); return T_status;}
"drawBreak"             {printf("%s", yytext); return T_drawBreak;}
"visualDraw"            {printf("%s", yytext); return T_visualDraw;}

"pricePoints"           {printf("%s ", yytext); return T_pricePoints;}
"amount"                {printf("%s ", yytext); return T_amount;}

"winningNumbers"        {printf("%s ", yytext); return T_winningNumbers;}
"list"                  {printf("%s ", yytext); return T_list;}
"bonus"                 {printf("%s ", yytext); return T_bonus;}

"prizeCategories"       {printf("%s ", yytext); return T_prizeCategories;}
"id"                    {printf("%s ", yytext); return T_id;}
"divident"              {printf("%s ", yytext); return T_divident;}
"winners"               {printf("%s ", yytext); return T_winners;}
"distributed"           {printf("%s ", yytext); return T_distributed;}
"jackpot"               {printf("%s ", yytext); return T_jackpot;}
"fixed"                 {printf("%s ", yytext); return T_fixed;}
"categoryType"          {printf("%s ", yytext); return T_categoryType;}
"gameType"              {printf("%s ", yytext); return T_gameType;}
"minimumDistributed"    {printf("%s ", yytext); return T_minimumDistributed;}

"wagerStatistics"       {printf("%s ", yytext); return T_wagerStatistics;}
"columns"               {printf("%s ", yytext); return T_columns;}
"wagers"                {printf("%s ", yytext); return T_wagers;}
"addOn"                 {printf("%s ", yytext); return T_addOn;}
%%

/*int main(int argc, char **argv)
{
yylex();
printf("FIN! %d",i);
return 0;
} */