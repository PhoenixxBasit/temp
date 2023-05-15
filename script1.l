%{
int count = 0;
%}

%%
A[a-zA-Z]* {printf("found %s of length %d\n", yytext , yyleng); found++;}
[A-Z] {printf("%s capital letter\n", yytext);   count++;}
.	 {printf("%s not a capital letter\n", yytext);}
\n {return 0;}
%%

int yywrap(){}
int main(){
    yylex();
    printf("\nNumber of Capital letters "
    	"in the given input - %d\n", count);
    return 0;
}



identifier [_a-zA-z][0-9a-zA-Z]*
number [1-9][0-9]*
equal [=]
operator [+\-/]|[][*]

%%
if          { printf("%s <IF>\n", yytext);}
{identifier} { printf("%s <ID>\n", yytext); }
[<] { printf("%s <LT>\n", yytext); }
[>] { printf("%s <GT>\n", yytext); }
{operator} { printf("%s <operator>\n", yytext); }
\n {return 0;}
%%

%%
"if"                { printf("<IF>"); }
"else"              { printf("<ELSE>"); }
"while"             { printf("<WHILE>"); }
"for"               { printf("<FOR>"); }
"int"               { printf("<INT>"); }
"float"             { printf("<FLOAT>"); }
"char"              { printf("<CHAR>"); }
"double"            { printf("<DOUBLE>"); }
"("                 { printf("<LPAREN>"); }
")"                 { printf("<RPAREN>"); }
"{"                 { printf("<LBRACE>"); }
"}"                 { printf("<RBRACE>"); }
";"                 { printf("<SEMICOLON>"); }
":"                 { printf("<COLON>"); }
","                 { printf("<COMMA>"); }

"=="                { printf("<EQUALS>"); }
">="                { printf("<GREATEREQ>"); }
"<="                { printf("<LESSEQ>"); }
">"                 { printf("<GREATER>"); }
"<"                 { printf("<LESS>"); }
"!="                { printf("<NOTEQUAL>"); }

"="                 { printf("<ASSIGN>"); }
"+"                 { printf("<PLUS>"); }
"-"                 { printf("<MINUS>"); }
"*"                 { printf("<MULT>"); }
"/"                 { printf("<DIV>"); }
"%"                 { printf("<MOD>"); }

[a-zA-Z_][a-zA-Z0-9_]* { printf("<ID>"); }
[ \t]               { /* ignore whitespace */ }
\/\/.*              { /* ignore comments */ }
\/\.\\/          { / ignore multi-line comments */ }
.                   { printf("<ERROR>"); }
%%

int main() {
    char input[100];

    printf("Enter input: ");
    fgets(input, 100, stdin);

    YY_BUFFER_STATE buffer = yy_scan_string(input);
    yylex();

    yy_delete_buffer(buffer);

    return 0;
}



int main(){
    FILE *fp;
    char filename[50];
    printf("Enter the filename: \n");
    scanf("%s",filename);
    fp = fopen(filename,"r");
    yyin = fp;
    yylex();
    printf("\nNumber of Capital letters "
      "in the given input - %d\n", count);
 
}



%option noyywrap
%{
    #include <stdio.h>
    int chars=0;
%}

%%
. {chars++;}
\n {chars++;}
%%

int main( int argc, char* argv[])
{
    if (argc==2)
        yyin = fopen(argv[1], "r");
    yylex();
    printf("%d \n", chars);
}


%option noyywrap
%{
    #include <stdio.h>
    #define LT 1
    #define GT 2
    #define OTHER 3
    int found=0;
%}

%%
[ \t\n]+ /*ignore whitespace */
\< { return LT;}
\> { return GT;}
. { return OTHER;}
%%

int main( int argc, char* argv[])
{
    if (argc==2)
        yyin = fopen(argv[1], "r");
    
    int ret;
    
    while (ret=yylex())
    {
        switch(ret){
            case LT:
                printf("<LT >");
                break;
            
            case GT:
                printf("<GT >");
                break;
            
            case OTHER:
                printf("<OTHER >");
                break;
        }
    }
    return 0;
}