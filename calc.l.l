%{
#include "y.tab.h"
#include "calc.h"
#include <math.h>
%}

D     [0-9]
A     [a-zA-Z]
AD    [a-zA-Z0-9]

%%

({D}+|({D}*\.{D}+)([eE][-+]?{D}+)?) { yylval.dval = atof(yytext); return NUMBER; }

{A}{AD}* { struct symtab *sp = symlook(yytext); yylval.symp = sp; return NAME; }

[ \t] ;

\n    |
.     return yytext[0];

%%

int yywrap() {
    return 1;
}
