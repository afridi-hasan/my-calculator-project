%{
#include "calc.h"
#include <string.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

int yylex();
int yyparse();
%}

%union {
  double dval;
  struct symtab *symp;
}

%token <symp> NAME
%token <dval> NUMBER

%right '='
%left '-' '+'
%left '*' '/'
%nonassoc UMINUS

%type <dval> expr

%%

session: /* empty */
         | session toplevel '\n'
         | session error
;

toplevel: expr { printf("%g\n\n>> ", $1); }
          | '?' { printHelp(); printf("\n>> "); }
          | '.' { printf("Exiting 331 calc\n"); exit(1); }
;

expr: NUMBER { $$ = $1; }
       | NAME { $$ = $1->value; }
       | NAME '=' expr { $1->value = $3; $$ = $3; }
       | expr '+' expr { $$ = $1 + $3; }
       | expr '-' expr { $$ = $1 - $3; }
       | expr '*' expr { $$ = $1 * $3; }
       | expr '/' expr { $$ = $1 / $3; }
       | '-' expr %prec UMINUS { $$ = -$2; }
       | '(' expr ')' { $$ = $2; }
;

%%

struct symtab *symlook(char *s) {
    char *p;
    struct symtab *sp;

    for(sp = symtab; sp < &symtab[SYMBOLTABLESIZE]; sp++) {
        if (sp->name && !strcmp(sp->name, s))
            return sp;

        if (!sp->name) {
            sp->name = strdup(s);
            return sp;
        }
    }

    yyerror("The symbol table is full, sorry...\n");
    exit(1);
}

void printHelp() {
    printf("Enter an expression in infix notation followed by a newline.\n");
    printf("Operators include +, -, *, /, and =.\n");
    printf("You can assign a variable using the = operator. Type . to exit.\n");
}

void yyerror(char *msg) {
    printf("%s \n", msg);  
}

int main() {
    printf("331 Calculator\n(type ? for help and . to exit)\n\n>> ");
    yyparse();
    return 0;
}
