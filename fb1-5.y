%{
#  include <stdio.h>
#  include <stdlib.h>
%}
%code requires { #define YYSTYPE double}

%token NUMBER
%token ADD SUB MUL DIV ABS
%token OP CP
%token EOL
%%

calclist: /* nothing */
 | calclist exp EOL { printf("= %.3lf\n> ", $2); }
 | calclist EOL { printf("> "); } /* blank line or a comment */
// | cmd { printf("call this \n");}
 ;

exp: factor
 | exp ADD exp {$$ = $1 + $3;}
 | exp SUB factor {	$$ = $1 - $3;}
 | exp ADD cmd { yyerror(" + error -  miss input right number \n");exit(1);}
 | cmd ADD exp { yyerror(" + error -  miss input left number \n");exit(1);}
 | exp SUB cmd { yyerror(" - error -  miss input right number \n");exit(1);}
 | cmd SUB exp { yyerror(" - error -  miss input left number \n");exit(1);}
;

factor: term
 | factor MUL term {$$ = $1 * $3;}
 | factor DIV term {$$ = $1 / $3;}
 | factor MUL cmd { yyerror(" * error -  miss input right number \n");exit(1);}
 | cmd MUL factor { yyerror(" * error -  miss input left number \n");exit(1);}
 | factor DIV cmd { yyerror(" / error -  miss input right number \n");exit(1);}
 | cmd DIV factor { yyerror(" / error -  miss input left number \n");exit(1);}
// | cmd
;

term: NUMBER
 | ABS term { $$ = $2 >= 0? $2 : - $2;}
 | OP exp CP { $$ = $2;	}
 | OP exp cmd { yyerror("miss CP\n"); exit(1);	}
 | cmd exp CP { yyerror("miss OP\n"); exit(1);	}
// | cmd
;
cmd: error {}
;

%%
main()
{
  printf("> "); 
  yyparse();
}

yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
}
