%%
%class AnalisadorLexico
%unicode
%cup
%line
%column

// EXPRESSÕES REGULARES
IDENTIFICADOR = [_a-zA-Z][_a-zA-Z0-9]*
INT = "int"
FLOAT = "float"
CHAR = "char"
NUM_REAL = [0-9]+("."[0-9]+)
NUM_INT = [0-9]+
CHAR_LITERAL = \'([^\'\\n\\r])\'
STRING_LITERAL = \"([^\"\\n\\r])*\"

// ERRO LÉXICO: número seguido por letras (ex: 123abc)
INVALID_ID = [0-9]+[_a-zA-Z]+[_a-zA-Z0-9]*

%%

/* PALAVRAS-CHAVE */
"if"              { return new Symbol(sym.IF, yyline+1, yycolumn+1); }
"else"            { return new Symbol(sym.ELSE, yyline+1, yycolumn+1); }
"switch"          { return new Symbol(sym.SWITCH, yyline+1, yycolumn+1); }
"case"            { return new Symbol(sym.CASE, yyline+1, yycolumn+1); }
"default"         { return new Symbol(sym.DEFAULT, yyline+1, yycolumn+1); }
"break"           { return new Symbol(sym.BREAK, yyline+1, yycolumn+1); }

/* OPERADORES RELACIONAIS */
"=="              { return new Symbol(sym.IGUAL_IGUAL, yyline+1, yycolumn+1); }
"!="              { return new Symbol(sym.DIFERENTE, yyline+1, yycolumn+1); }
"<="              { return new Symbol(sym.MENOR_IGUAL, yyline+1, yycolumn+1); }
">="              { return new Symbol(sym.MAIOR_IGUAL, yyline+1, yycolumn+1); }
"<"               { return new Symbol(sym.MENOR, yyline+1, yycolumn+1); }
">"               { return new Symbol(sym.MAIOR, yyline+1, yycolumn+1); }

/* OPERADORES MATEMÁTICOS E DE ATRIBUIÇÃO */
"+"               { return new Symbol(sym.MAIS, yyline+1, yycolumn+1); }
"-"               { return new Symbol(sym.MENOS, yyline+1, yycolumn+1); }
"*"               { return new Symbol(sym.MULT, yyline+1, yycolumn+1); }
"/"               { return new Symbol(sym.DIV, yyline+1, yycolumn+1); }
"="               { return new Symbol(sym.IGUAL, yyline+1, yycolumn+1); }

/* SÍMBOLOS */
"("               { return new Symbol(sym.ABRE_PAREN, yyline+1, yycolumn+1); }
")"               { return new Symbol(sym.FECHA_PAREN, yyline+1, yycolumn+1); }
"{"               { return new Symbol(sym.ABRE_CHAVE, yyline+1, yycolumn+1); }
"}"               { return new Symbol(sym.FECHA_CHAVE, yyline+1, yycolumn+1); }
":"               { return new Symbol(sym.DOIS_PONTOS, yyline+1, yycolumn+1); }
";"               { return new Symbol(sym.PVIRG, yyline+1, yycolumn+1); }
","               { return new Symbol(sym.VIRG, yyline+1, yycolumn+1); }

/* TIPOS PRIMITIVOS */
{INT}             { return new Symbol(sym.INT, yyline+1, yycolumn+1); }
{FLOAT}           { return new Symbol(sym.FLOAT, yyline+1, yycolumn+1); }
{CHAR}            { return new Symbol(sym.CHAR, yyline+1, yycolumn+1); }

/* IDENTIFICADORES */
{IDENTIFICADOR}   { return new Symbol(sym.IDENTIFICADOR, yyline+1, yycolumn+1, yytext()); }

/* NÚMEROS */
// IMPORTANTE: NUM_REAL vem ANTES de NUM_INT!
{NUM_REAL}        { return new Symbol(sym.NUM_REAL, yyline+1, yycolumn+1, Float.parseFloat(yytext())); }
{NUM_INT}         { return new Symbol(sym.NUM_INT, yyline+1, yycolumn+1, Integer.parseInt(yytext())); }

/* LITERAIS */
{CHAR_LITERAL}    { return new Symbol(sym.CHAR_LITERAL, yyline+1, yycolumn+1, yytext()); }
{STRING_LITERAL}  { return new Symbol(sym.STRING_LITERAL, yyline+1, yycolumn+1, yytext()); }

/* ERROS LÉXICOS */
{INVALID_ID}      { System.err.println("Erro léxico: identificador inválido: " + yytext()); return new Symbol(sym.ERROR); }

/* IGNORAR ESPAÇOS E COMENTÁRIOS */
[ \t\r\n]+        { /* ignora espaços */ }
"//".*            { /* ignora comentários de linha */ }
"/*"([^*]|[\r\n]|"*"[^/])*"*/" { /* ignora comentários de bloco */ }

/* CARACTERES INVÁLIDOS */
.                 { System.err.println("Caractere inválido: " + yytext()); return new Symbol(sym.ERROR); }
