# Makefile for simple lex and yacc examples

# Define the compiler and tools
CC = gcc
FLEX = flex
BISON = bison

# Files
LEX_FILE = calc.l
YACC_FILE = calc.y
HEADER_FILE = calc.h

# Output files
LEX_OUTPUT = lex.yy.c
YACC_OUTPUT = y.tab.c
YACC_HEADER = y.tab.h
EXECUTABLE = calc

# Rules
all: $(EXECUTABLE)

$(EXECUTABLE): $(YACC_OUTPUT) $(LEX_OUTPUT)
	$(CC) -o $(EXECUTABLE) $(YACC_OUTPUT) $(LEX_OUTPUT) -lm

$(LEX_OUTPUT): $(LEX_FILE) $(YACC_HEADER)
	$(FLEX) $(LEX_FILE)

$(YACC_OUTPUT) $(YACC_HEADER): $(YACC_FILE)
	$(BISON) -d -o $(YACC_OUTPUT) $(YACC_FILE)

clean:
	rm -f $(LEX_OUTPUT) $(YACC_OUTPUT) $(YACC_HEADER) $(EXECUTABLE)

.PHONY: all clean
