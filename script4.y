%{
    #include <cstdio >
    #include <cstdlib >
    #include <iostream >
    using namespace std;
    
    //declare lexical analyzer. This will be generated using lex.
    int yylex(void) ;
    
    //input file pointer
    extern FILE* yyin;
    
    //This function is called on error
    void yyerror( const char *);
%}

/* tokens will be declared in the .y file now */
%token NUM

%%
exprlist: exprlist expr ';'
            | ;

expr: term | expr '+' term
        ;

term: NUM;
%%

void yyerror(const char *error)
{
    std::cerr<<error<<'\n';
}

int main(int argc, char *argv[])
{
    if (argc==2)
        yyin = fopen(argv[1], "r");
    
    //run parser
    yyparse();
    
    return 0;
}

%option noyywrap
%{
    #include <cstdlib >
    using namespace std;
    
    //since we are using bison ,
    //token declarations are now in the
    //following header
    #include "example.tab.h"
%}

%%
[ \t]+ ;
[0-9]+ { return NUM;}
. { return *yytext;}
%%


%{
    #include <stdio.h>
    #include <stdlib.h>
    
    //declare lexical analyzer. This will be generated using lex.
    int yylex(void) ;
    
    //input file pointer
    extern FILE* yyin;
    
    //This function is called on error
    void yyerror( const char *);
%}

/* tokens will be declared in the .y file now */
%token NUM

%%
exprlist: exprlist expr ';' {printf(" %d\n", $2);}
            | ;

expr: term {$$ = $1;}
        | expr '+' term {$$ = $1 + $3;}
        ;

term: NUM {$$ = $1;};
%%

void yyerror(const char *error)
{
    printf("%s \n",error);
}

int main(int argc, char *argv[])
{
    if (argc==2)
        yyin = fopen(argv[1], "r");
    
    //run parser
    yyparse();
    
    return 0;
}

%option noyywrap
%{
    #include <stdlib.h>
    
    //since we are using bison ,
    //token declarations are now in the
    //following header
    #include "n.tab.h"
%}

%%
[ \t]+ ;
[0-9]+ { yylval = atoi(yytext);
        return NUM;}
. { return *yytext;}
%%


%{
    #include <stdio.h>
    int yylex(void) ;
    extern FILE* yyin;
%}

%token NUM
%left '+' '-'
%left '*' '/'

%%
exprlist: exprlist expr '\n' {printf("result: %d\n", $2);}
            | ;

expr: expr '+' expr {$$ = $1 + $3;}
        | expr '+' expr {$$ = $1 + $3;}
        | NUM {$$ = $1;}
        ;

%%

int main(int argc, char *argv[])
{
    if (argc==2)
        yyin = fopen(argv[1], "r");
    
    yyparse();
    return 0;
}