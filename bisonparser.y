//header files

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    extern int yylineno;
    extern char* yytext;
    int yylex();
    void yyerror(const char *msg);

    int error=0;

    FILE *yyin;
%}


%token LCURLY RCURLY LBRACKET RBRACKET COLON COMMA
%token QUOTE
%token INT jsonString FLOAT jsonArray jsonNumber

%token T_wagerStatistics T_columns T_wagers T_addOn
%token T_prizeCategories T_id T_divident T_winners T_distributed T_jackpot T_fixed T_categoryType T_gameType T_minimumDistributed
%token T_winningNumbers T_list T_bonus
%token T_pricePoints T_amount
%token T_gameId T_drawId T_drawTime T_status T_drawBreak T_visualDraw
%token T_last T_active 
%%

jsonfile: object
                           {printf("/n");};
object: LCURLY  RCURLY
                           {printf(" { }/n ");}
                        | LCURLY fields RCURLY
                           {    printf("{"); //;;
                                printf("/n");
                                printf("}");   };
fields: last active;
last: COLON LCURLY gameId drawId drawTime status drawBreak visualDraw pricePoints winningNumbers prizeCategories wagerStatistics RCURLY COMMA;
gameId:  QUOTE T_gameId QUOTE COLON id COMMA;
drawId: QUOTE T_drawId QUOTE COLON INT COMMA;
drawTime: QUOTE T_drawTime QUOTE COLON INT COMMA;
status: QUOTE T_status QUOTE COLON  jsonString  COMMA;
drawBreak: QUOTE T_drawBreak QUOTE COLON INT COMMA;
visualDraw: QUOTE T_visualDraw QUOTE COLON INT COMMA;
pricePoints: QUOTE T_pricePoints QUOTE COLON LCURLY amount RCURLY COMMA;
amount: QUOTE T_amount QUOTE COLON FLOAT;
winningNumbers: QUOTE T_winningNumbers QUOTE COLON LCURLY list COMMA bonus;
list: QUOTE T_list QUOTE COLON jsonArray COMMA;
bonus: QUOTE T_bonus QUOTE COLON jsonArray COMMA;
/*Δεν ξερουμε τι παιζει*/
prizeCategories: QUOTE T_prizeCategories QUOTE COLON jsonArrayprize COMMA;
jsonArrayprize: LBRACKET   RBRACKET;
wagerStatistics: QUOTE T_wagerStatistics QUOTE COLON LCURLY columns COMMA wagers addOn;
columns: QUOTE T_columns QUOTE COLON INT;
wagers: QUOTE T_wagers QUOTE COLON INT;
addOn: QUOTE T_addOn QUOTE jsonArray;
id: jsonNumber
                      {if(jsonNumber!=1100||1110||2100||2101||5103||5104||5106){
                        printf("%d\n", $1);}
                        else
                        {
                            //yyerror(char *msg);
                            error++;
                        }};

active: COLON LCURLY gameId drawId drawTime status drawBreak visualDraw pricePoints prizeCategories wagerStatistics RCURLY COMMA ;

%%
void yyerror(const char *msg) {
    printf("%s on line %d\n", msg, yylineno);
    error++;
    exit(1);
}
int main(int argc, char* argv[]) {
	FILE *f;
	f = fopen(argv[1], "r");
	yyin = f;
	yyparse();
	printf("\n Parsing... \n");
	if (error==0) printf("** No Errors Found \n");
	else  printf(" Code has %d Errors !\n",error);
      return 0;
}