%{
#include <stdio.h>
int lineno = 1;
FILE* outputFile;
%}

%option noyywrap

%%

[ \t]+                     /* skip white spaces */
\n                         { lineno++; }  /* increase line count for each new line */

"def"                      { fprintf(outputFile, "Line no %d: Token <DEF> Lexeme def found\n", lineno); }
"for"                      { fprintf(outputFile, "Line no %d: Token <FOR> Lexeme for found\n", lineno); }
"in"                       { fprintf(outputFile, "Line no %d: Token <IN> Lexeme in found\n", lineno); }
"range"                    { fprintf(outputFile, "Line no %d: Token <RANGE> Lexeme range found\n", lineno); }
"print"                    { fprintf(outputFile, "Line no %d: Token <PRINT> Lexeme print found\n", lineno); }
"if"                       { fprintf(outputFile, "Line no %d: Token <IF> Lexeme if found\n", lineno); }
"else"                     { fprintf(outputFile, "Line no %d: Token <ELSE> Lexeme else found\n", lineno); }
"return"                   { fprintf(outputFile, "Line no %d: Token <RETURN> Lexeme return found\n", lineno); }

[0-9]+                     { fprintf(outputFile, "Line no %d: Token <CONST_INT> Lexeme %s found\n", lineno, yytext); }
[0-9]*"."[0-9]+            { fprintf(outputFile, "Line no %d: Token <CONST_FLOAT> Lexeme %s found\n", lineno, yytext); }

"="                        { fprintf(outputFile, "Line no %d: Token <ASSIGNOP> Lexeme = found\n", lineno); }
">"                        { fprintf(outputFile, "Line no %d: Token <RELOP> Lexeme > found\n", lineno); }
\(                         { fprintf(outputFile, "Line no %d: Token <LPAREN> Lexeme ( found\n", lineno); }
\)                         { fprintf(outputFile, "Line no %d: Token <RPAREN> Lexeme ) found\n", lineno); }
":"                        { fprintf(outputFile, "Line no %d: Token <COLON> Lexeme : found\n", lineno); }

[a-zA-Z_][a-zA-Z0-9_]*     { fprintf(outputFile, "Line no %d: Token <ID> Lexeme %s found\n", lineno, yytext); }

%%

int main(int argc, char* argv[]) {
    if (argc < 2) {
        printf("Specify an input file.\n");
        return 1;
    }
    FILE* inputFile = fopen(argv[1], "r");
    if (!inputFile) {
        printf("Unable to open the input file.\n");
        return 1;
    }
    outputFile = fopen("my_log.txt", "w");
    if (!outputFile) {
        printf("Unable to open the output file.\n");
        return 1;
    }

    yyin = inputFile;
    yylex();

    fprintf(outputFile, "\n\nTotal lines: %d\n", lineno);

    fclose(inputFile);
    fclose(outputFile);
    return 0;
}
