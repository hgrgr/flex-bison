%{
# include "fb1-5.tab.h"
%}

%%
"+" { return ADD; }
"-" { return SUB; }
"*" { return MUL; }
"/" { return DIV; }
"|" { return ABS; }
"(" { return OP; }
")" { return CP; }
[-+]?([0-9]*\.?[0-9]+|[0-9]+\.)(E[+-}?[0-9]+)? {
    yylval = atof(yytext); return NUMBER;}
\n { return EOL; }
"//".*
[ \t]   { /* ignore white space */ }
.   { yyerror("Mystery character %c\n", *yytext); }
%%