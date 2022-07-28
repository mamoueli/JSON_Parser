
//header files

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    extern int yylineno;
    extern char* yytext;
    int yylex();
    void yyerror(const char *msg);
%}


%token LCURLY RCURLY LBRACKET RBRACKET COLON COMMA
%token QUOTE
%token T_gameId T_drawId T_drawtime T_status T_drawbreak T_visualdraw
%token T_pricepoints T_amount T_winningnumbers T_list T_bonus T_prizecat T_wagerstatistics
%token T_columns T_wagers T_addon
%token INT jsonString FLOAT jsonArray jsonNumber

%%

jsonfile: object               {printf("/n");}

       ;

object: LCURLY  RCURLY         {printf(" { }/n ");}

       | LCURLY fields RCURLY
                           {    printf("{"); //;;
                                printf("/n");
                                printf("}");   }
       ;

fields: last active

       ;
last: COLON LCURLY gid drawid drawtime status drawbreak visualdraw pricepoints winningnumbers prizecategories wagerstatistics RCURLY COMMA
      ;

gid:  QUOTE T_gameId QUOTE COLON id COMMA
      ;



drawid: QUOTE T_drawId QUOTE COLON INT COMMA

      ;

drawtime: QUOTE T_drawtime QUOTE COLON INT COMMA

      ;

status: QUOTE T_status QUOTE COLON  jsonString  COMMA

      ;

drawbreak: QUOTE T_drawbreak QUOTE COLON INT COMMA

         ;

visualdraw: QUOTE T_visualdraw QUOTE COLON INT COMMA

          ;

pricepoints: QUOTE T_pricepoints QUOTE COLON LCURLY Amount RCURLY COMMA

          ;

Amount: QUOTE T_amount QUOTE COLON FLOAT

      ;

winningnumbers: QUOTE T_winningnumbers QUOTE COLON LCURLY List COMMA Bonus

              ;

List: QUOTE T_list QUOTE COLON jsonArray COMMA

    ;

Bonus: QUOTE T_bonus QUOTE COLON jsonArray COMMA

     ;

/*Δεν ξερουμε τι παιζει*/
prizecategories: QUOTE T_prizecat QUOTE COLON jsonArrayprize COMMA


               ;

jsonArrayprize: LBRACKET   RBRACKET
              ;

wagerstatistics: QUOTE T_wagerstatistics QUOTE COLON LCURLY COLUMNS COMMA WAGERS ADDON

               ;

COLUMNS: QUOTE T_columns QUOTE COLON INT

       ;

WAGERS: QUOTE T_wagers QUOTE COLON INT

      ;

ADDON: QUOTE T_addon QUOTE jsonArray

      ;


id: jsonNumber
                      {if(jsonNumber!=1100||1110||2100||2101||5103||5104||5106){

                        printf("%d\n", $1);}

                        else
                        {
                            //yyerror(char *msg);
                        }
                        }

    ;

active: COLON LCURLY gid drawid drawtime status drawbreak visualdraw pricepoints winningnumbers prizecategories wagerstatistics RCURLY COMMA


       ;


%%


void yyerror(const char *msg) {
    fprintf(stderr, "%s on line %d\n", msg, yylineno);
    exit(1);
}
