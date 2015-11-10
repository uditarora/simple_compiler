%{
	/*
		Developed By: Udit Arora
	*/
	#include <stdlib.h>
	#include <stdio.h>
	#include "y.tab.h"
	void yyerror(char *);
	#define DEBUG_OUT 0
	int yylineno;
%}

digit [0-9]
small_letter [a-z]
capital_letter [A-Z]
whitespace [ \t]+

%%

{digit}+ { 
	yylval = atoi(yytext);
	if (DEBUG_OUT)
		printf("Found integer: %d\n", yylval);
	return INT;
}

{small_letter} {
	/* Single char variables. Case-invariant */
	yylval = *yytext-'a';
	if (DEBUG_OUT)
		printf("Found variable: %c\n", *yytext);
	return VAR;
}
{capital_letter} {
	yylval = *yytext-'A';
	if (DEBUG_OUT)
		printf("Found variable: %c\n", *yytext);
	return VAR;
}

"**" {
	if (DEBUG_OUT)
		printf("Found token: %s\n", yytext);
	return POW;
}
"<<" {
	if (DEBUG_OUT)
		printf("Found token: %s\n", yytext);
	return LSHIFT;
}
">>" {
	if (DEBUG_OUT)
		printf("Found token: %s\n", yytext);
	return RSHIFT;
}

[-()<>=+*/&|;{}] {
	if (DEBUG_OUT)
		printf("Found token: %c\n", *yytext);
	return *yytext;
}

"<=" {
	if (DEBUG_OUT)
		printf("Found token: %s\n", yytext);
	return LE;
}
">=" {
	if (DEBUG_OUT)
		printf("Found token: %s\n", yytext);
	return GE;
}
"==" {
	if (DEBUG_OUT)
		printf("Found token: %s\n", yytext);
	return EQ;
}
"!=" {
	if (DEBUG_OUT)
		printf("Found token: %s\n", yytext);
	return NE;
}

"while" {
	if (DEBUG_OUT)
		printf("Found token: %s\n", yytext);
	return WHILE;
}
"print" {
	if (DEBUG_OUT)
		printf("Found token: %s\n", yytext);
	return PRINT;
}
"input" {
	if (DEBUG_OUT)
		printf("Found token: %s\n", yytext);
	return INPUT;
}
"if" {
	if (DEBUG_OUT)
		printf("Found token: %s\n", yytext);
	return IF;
}
"else" {
	if (DEBUG_OUT)
		printf("Found token: %s\n", yytext);
	return ELSE;
}
"def" {
	if (DEBUG_OUT)
		printf("Found token: %s\n", yytext);
	return DEF;
}
[\n\r] {
	if (DEBUG_OUT)
		printf("Incrementing linenum\n");
	yylineno++;
}
{whitespace}	;

. {
	yyerror("Unknown token");
}
%%