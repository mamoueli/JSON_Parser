/* Scanner for json*/
%{
//declarations
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "json1.tab.h"
int line=1;
%}

%x COMMENTS

LETTER [a-zA-Z]
DIGIT  [0-9]
DIGITS {DIGIT}+
EXP {E}{DIGITS}
E [eE][+-]?
HEX_DIGIT [0-9a-f]
UNESCAPEDCHAR [ -!#-\[\]-~]
ESCAPEDCHAR \\["\\bfnrt/]
UNICODECHAR \\u{HEX_DIGIT}{HEX_DIGIT}{HEX_DIGIT}{HEX_DIGIT}
CHAR {UNESCAPEDCHAR}|{ESCAPEDCHAR}|{UNICODECHAR}
STR {CHAR}+



%%
<INITIAL>"\""             {printf("%s",yytext);}BEGIN(COMMENTS);
<COMMENTS>"\""            {printf("%s",yytext);}BEGIN(INITIAL);
<COMMENTS>" \n "          {continue;}

true                      {printf("%s ", yytext); return TRUE;}
false                     {printf("%s ", yytext); return FALSE;}

\"last\"                  {printf("%s ", yytext); return T_last;}
\"active\"                {printf("%s ", yytext); return T_active;}

\"gameId\"                {printf("%s ", yytext); return T_gameId;}
\"drawId\"                {printf("%s ", yytext); return T_drawId;}
\"drawTime\"              {printf("%s ", yytext); return T_drawTime;}
\"status\"                {printf("%s", yytext); return T_status;}
\"drawBreak\"             {printf("%s", yytext); return T_drawBreak;}
\"visualDraw\"            {printf("%s", yytext); return T_visualDraw;}

\"pricePoints\"           {printf("%s ", yytext); return T_pricePoints;}
\"amount\"                {printf("%s ", yytext); return T_amount;}

\"winningNumbers\"        {printf("%s ", yytext); return T_winningNumbers;}
\"list\"                  {printf("%s ", yytext); return T_list;}
\"bonus\"                 {printf("%s ", yytext); return T_bonus;}

\"prizeCategories\"       {printf("%s ", yytext); return T_prizeCategories;}
\"id\"                    {printf("%s ", yytext); return T_id;}
\"divident\"              {printf("%s ", yytext); return T_divident;}
\"winners\"               {printf("%s ", yytext); return T_winners;}
\"distributed\"           {printf("%s ", yytext); return T_distributed;}
\"jackpot\"               {printf("%s ", yytext); return T_jackpot;}
\"fixed\"                 {printf("%s ", yytext); return T_fixed;}
\"categoryType\"          {printf("%s ", yytext); return T_categoryType;}
\"gameType\"              {printf("%s ", yytext); return T_gameType;}
\"minimumDistributed\"    {printf("%s ", yytext); return T_minimumDistributed;}

\"wagerStatistics\"       {printf("%s ", yytext); return T_wagerStatistics;}
\"columns\"               {printf("%s ", yytext); return T_columns;}
\"wagers\"                {printf("%s ", yytext); return T_wagers;}
\"addOn\"                 {printf("%s ", yytext); return T_addOn;}

1100|1110|2100|2101|5103|5104|5106 {printf("%s",yytext);return gid;}

\{                        {printf("\n{"); return LCURLY;}
\}                        {printf("\n}"); return RCURLY;}
,                         {printf(","); return COMMA;}
:                         {printf(":"); return COLON;}




{LETTER}                 {printf("%s", yytext); return T_LETTER; }
\"{DIGITS}\"	           {printf("%s", yytext); return T_stringNum; }
\"{STR}\"	               {printf("%s", yytext); return T_jsonString; }
{DIGITS}	               {printf("%s", yytext); return T_jsonNum; }

[0-9]+\.?[0-9]*{EXP}?    {printf("%s",yytext); return jsonNumber;}

\n 	                     {printf("%s",yytext); line++; }
\[                       {printf("%s",yytext); return LBRACKET;}
\]                       {printf("%s",yytext); return RBRACKET;}
%%
