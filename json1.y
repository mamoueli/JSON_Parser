//header files
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

       FILE *yyin;

    extern char* yytext;
    int yylex();
    void yyerror(const char *msg);
    extern int line;
    int error=0;


%}
//token declaration
%token TRUE FALSE
%token T_last T_active
%token T_gameId T_drawId T_drawTime
%token T_status T_drawBreak
%token T_visualDraw T_pricePoints T_amount
%token T_winningNumbers T_list T_bonus
%token T_prizeCategories T_id T_divident T_winners T_distributed
%token T_jackpot T_fixed T_categoryType
%token T_gameType T_minimumDistributed
%token T_wagerStatistics T_columns T_wagers T_addOn
%token LCURLY RCURLY COMMA COLON LBRACKET RBRACKET
%token T_LETTER T_stringNum T_jsonString
%token T_jsonNum
%token jsonNumber gid

%token T_content T_totalPages T_totalElements T_numberOfElements T_sort T_first T_size
%token T_number T_direction T_property T_ignoreCase T_nullHandling T_descending T_ascending
%%

//extended bison from line 39 to line 75 for part 2
jsonfile: LCURLY object RCURLY | LCURLY extention RCURLY;

extention: T_content COLON LBRACKET contentBody RBRACKET COMMA totalPages COMMA totalElements COMMA newLast COMMA numberOfElements COMMA sort COMMA first COMMA size COMMA number ;

contentBody: LCURLY contentTerms RCURLY | contentBody COMMA LCURLY contentTerms RCURLY ;

contentTerms:  gameId COMMA drawId COMMA drawTime COMMA statusLast COMMA drawBreak COMMA visualDraw COMMA pricePoints COMMA winningNumbers COMMA prizeCategories COMMA wagerStatistics;

totalPages: T_totalPages COLON T_jsonNum;

totalElements: T_totalElements COLON T_jsonNum;

newLast:T_last COLON TRUE;

numberOfElements: T_numberOfElements COLON T_jsonNum;

sort: T_sort COLON LBRACKET LCURLY sortFields RCURLY RBRACKET ;

sortFields: direction COMMA property COMMA ignoreCase COMMA nullHandling COMMA descending COMMA ascending ;

direction: T_direction COLON T_jsonString;

property: T_property COLON T_jsonString;

ignoreCase: T_ignoreCase COLON FALSE;

nullHandling: T_nullHandling COLON T_jsonString;

descending: T_descending COLON TRUE;

ascending: T_ascending COLON FALSE;

first: T_first COLON TRUE ;

size: T_size COLON T_jsonNum;

number: T_number COLON T_jsonNum;


//bison for part 1
object: fields | object COMMA fields ;

fields: last COMMA active ;

last: T_last COLON LCURLY lastfields RCURLY  ;

active: T_active COLON LCURLY activefields RCURLY;

lastfields: gameId COMMA drawId COMMA drawTime COMMA statusLast COMMA drawBreak COMMA visualDraw COMMA pricePoints COMMA winningNumbers COMMA prizeCategories COMMA wagerStatistics;

activefields: gameId COMMA drawId COMMA drawTime COMMA statusActive COMMA drawBreak COMMA visualDraw COMMA pricePoints COMMA prizeCategories COMMA wagerStatistics ;

gameId:  T_gameId  COLON  gid
         | T_gameId  COLON T_jsonNum { yyerror(" \n Wrong id");} ; //checks if gameId is correct

drawId: T_drawId COLON T_jsonNum   ;

drawTime: T_drawTime COLON T_jsonNum   ;

statusLast: T_status COLON T_jsonString  ;

statusActive: T_status COLON T_active ;

drawBreak: T_drawBreak COLON T_jsonNum  ;

visualDraw: T_visualDraw COLON T_jsonNum  ;

pricePoints: T_pricePoints COLON LCURLY pricepointsbody RCURLY  ;

pricepointsbody: T_amount COLON jsonNumber;

winningNumbers : T_winningNumbers COLON  LCURLY winningnumsbody RCURLY ;

winningnumsbody : list COMMA bonus ;

list: T_list COLON LBRACKET  listarray RBRACKET;

listarray: T_jsonNum | listarray COMMA T_jsonNum ;

bonus: T_bonus COLON LBRACKET  bonusarray RBRACKET;

bonusarray: T_jsonNum ;

prizeCategories: T_prizeCategories COLON LBRACKET prizecatbody RBRACKET;

prizecatbody: prizecatterms1 COMMA  prizecatids ;

prizecatids: prizecatterms2 | prizecatids COMMA prizecatterms2;

prizecatterms1: LCURLY id COMMA divident COMMA winners COMMA distributed COMMA jackpot COMMA fixed COMMA categoryType COMMA gameType COMMA minimumDistributed RCURLY;

prizecatterms2: LCURLY id COMMA divident COMMA winners COMMA distributed COMMA jackpot COMMA fixed COMMA categoryType COMMA gameType RCURLY ;

id: T_id COLON T_jsonNum;

divident: T_divident COLON jsonNumber ;

winners: T_winners COLON T_jsonNum ;

distributed: T_distributed COLON jsonNumber ;

jackpot: T_jackpot COLON jsonNumber ;

fixed: T_fixed COLON jsonNumber ;

categoryType: T_categoryType COLON T_jsonNum;

gameType: T_gameType COLON T_jsonString ;

minimumDistributed: T_minimumDistributed COLON jsonNumber
    ;

wagerStatistics: T_wagerStatistics COLON LCURLY wagerstatsbody RCURLY;


wagerstatsbody: columns COMMA wagers COMMA addOn ;

columns: T_columns COLON T_jsonNum ;

wagers: T_wagers COLON T_jsonNum ;

addOn: T_addOn COLON LBRACKET addOnarray RBRACKET;

addOnarray: T_jsonNum | %empty ;




%%


void yyerror(const char *msg) {
    printf(" %s on line %d\n", msg, line);
    error++;
    exit(1);
}
int main(int argc, char* argv[]) {
	FILE *f;
	f = fopen(argv[1], "r");
	yyin = f;
	yyparse();
	printf("\n\n\n Parsing in progress... \n");
	if (error==0) printf(" No Errors Found \n");
	else  printf(" Code has %d Errors !\n",error);
      return 0;
}
