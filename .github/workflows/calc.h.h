#ifndef CALC_H
#define CALC_H

#define SYMBOLTABLESIZE 20

/* An entry in the symbol table has a name, a pointer to a function,
   and a numeric value. */
struct symtab {
  char *name;
  double (*funcptr)();
  double value;
};

/* Declare symtab as extern to prevent multiple definitions */
extern struct symtab symtab[SYMBOLTABLESIZE];

struct symtab *symlook();

void printHelp();
void yyerror();
#endif
