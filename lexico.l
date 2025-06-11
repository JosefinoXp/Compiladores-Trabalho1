%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "tokens.h"

// Variável global para rastrear a linha atual do arquivo
int linha = 1;
%}

%option noyywrap  


IF (se)
ELSE (senao)
SWITCH (comparar)
CASE (caso)


MAIN (inicio)
RETURN (retorna)
REMOVE (remove)
INCLUDE (#inclua)
DEFINE (#defina)


PARENTESES_ESQUERDA "("
PARENTESES_DIREITA ")"
CHAVES_esq "{"
CHAVES_dir "}"
COLCHETES_dir "["
COLCHETES_esq "]"


FOR (para)
WHILE (enquanto)
DO (faca)
BREAK (pare)


PRINTF (imprima)
SCANF (escaneie)


SIZEOF (tamanhoDe)
MALLOC (aloca)


STRUCT (estrutura)
FLOAT (decimal)
INT (inteiro)
DOUBLE (real)
CHAR (caractere)
VOID (vazio)


ADD ("+")
SUB ("-")
ATRIB ("=")
DIVISAO ("/")
MULTIPLICACAO ("*")
RESTO ("%")


AND (&&)
OR ("||")
NOT ("!")


CADEIA \"([^\\\"]|\\.)*\"   

IGUAL ("==")
MAIOR_OU_IGUAL (">=")
MENOR_OU_IGUAL ("<=")
DIFERENTE ("!=")
MAIOR (">")
MENOR ("<")


LETRA [a-zA-Z_]
DIGITO [0-9]


NUMERO {DIGITO}+|{DIGITO}+.{DIGITO}+

IDENTIFICADOR {LETRA}({LETRA}|{DIGITO})*


ERROVARIAVEL {DIGITO}+{LETRA}+({DIGITO}|{LETRA})*       
ERRONUM {DIGITO}+\.
ERROCADEIA \"([^\\\"\n]|\\.)*

ERRO_DECIMAL_VIRGULA {DIGITO}+","{DIGITO}+

VIRGULA ","
E_COMERCIAL "&"


ESPECIFICADORDEFORMATO \"%[dsf]\"

%%


" "          { }


{ESPECIFICADORDEFORMATO} {
    listaToken = insereNaLista(listaToken, yytext, "especificador_de_formato", "\0", linha);
}


{VIRGULA} {
    listaToken = insereNaLista(listaToken, yytext, "simbolo_virgula", "\0", linha);
}


{E_COMERCIAL} {
    listaToken = insereNaLista(listaToken, yytext, "operador_endereco", "\0", linha);
}


{CADEIA} {
    listaToken = insereNaLista(listaToken, yytext, "cadeia", "\0", linha);
}

{ERRO_DECIMAL_VIRGULA} {
    printf("Token: %s\nTipo de token: numero\nErro: numeros decimais nao podem usar virgula\nLinha: %d\n\n", yytext, linha);
}


{MAIN}     { listaToken = insereNaLista(listaToken, yytext, "funcao_inicio", "\0", linha); }
{NUMERO}   { listaToken = insereNaLista(listaToken, yytext, "numero", "\0", linha); }
{RETURN}   { listaToken = insereNaLista(listaToken, yytext, "palavraChave_retorno", "\0", linha); }
{REMOVE}   { listaToken = insereNaLista(listaToken, yytext, "palavraChave_remove", "\0", linha); }
{INCLUDE}  { listaToken = insereNaLista(listaToken, yytext, "palavraChave_inclua", "\0", linha); }
{DEFINE}   { listaToken = insereNaLista(listaToken, yytext, "palavraChave_defina", "\0", linha); }

{IF}       { listaToken = insereNaLista(listaToken, yytext, "condicional_se", "\0", linha); }
{ELSE}     { listaToken = insereNaLista(listaToken, yytext, "condicional_senao", "\0", linha); }
{SWITCH}   { listaToken = insereNaLista(listaToken, yytext, "condicional_compare", "\0", linha); }
{CASE}     { listaToken = insereNaLista(listaToken, yytext, "condicional_caso", "\0", linha); }

{FOR}      { listaToken = insereNaLista(listaToken, yytext, "repeticao_para", "\0", linha); }
{WHILE}    { listaToken = insereNaLista(listaToken, yytext, "repeticao_enquanto", "\0", linha); }
{DO}       { listaToken = insereNaLista(listaToken, yytext, "repeticao_faca", "\0", linha); }
{BREAK}    { listaToken = insereNaLista(listaToken, yytext, "repeticao_pare", "\0", linha); }

{PRINTF}   { listaToken = insereNaLista(listaToken, yytext, "funcao_imprima", "\0", linha); }
{SCANF}    { listaToken = insereNaLista(listaToken, yytext, "funcao_escaneie", "\0", linha); }

{SIZEOF}   { listaToken = insereNaLista(listaToken, yytext, "funcao_tamanhoDe", "\0", linha); }
{MALLOC}   { listaToken = insereNaLista(listaToken, yytext, "funcao_aloca", "\0", linha); }

{STRUCT}   { listaToken = insereNaLista(listaToken, yytext, "tipo_estrutura", "\0", linha); }
{VOID}     { listaToken = insereNaLista(listaToken, yytext, "tipo_vazio", "\0", linha); }
{INT}      { listaToken = insereNaLista(listaToken, yytext, "tipo_inteiro", "\0", linha); }
{FLOAT}    { listaToken = insereNaLista(listaToken, yytext, "tipo_decimal", "\0", linha); }
{DOUBLE}   { listaToken = insereNaLista(listaToken, yytext, "tipo_real", "\0", linha); }
{CHAR}     { listaToken = insereNaLista(listaToken, yytext, "tipo_caractere", "\0", linha); }

{ADD}        { listaToken = insereNaLista(listaToken, yytext, "operador_adicionar", "\0", linha); }
{SUB}        { listaToken = insereNaLista(listaToken, yytext, "operador_subtrair", "\0", linha); }
{ATRIB}      { listaToken = insereNaLista(listaToken, yytext, "operador_atribuicao", "\0", linha); }
{DIVISAO}    { listaToken = insereNaLista(listaToken, yytext, "operador_divisao", "\0", linha); }
{MULTIPLICACAO} { listaToken = insereNaLista(listaToken, yytext, "operador_multiplicacao", "\0", linha); }
{RESTO}      { listaToken = insereNaLista(listaToken, yytext, "operador_resto", "\0", linha); }

{AND}        { listaToken = insereNaLista(listaToken, yytext, "operador_e", "\0", linha); }
{OR}         { listaToken = insereNaLista(listaToken, yytext, "operador_ou", "\0", linha); }
{NOT}        { listaToken = insereNaLista(listaToken, yytext, "operador_nao", "\0", linha); }

{PARENTESES_ESQUERDA} { listaToken = insereNaLista(listaToken, yytext, "simbolo_parentesesEsquerda", "\0", linha); }
{PARENTESES_DIREITA}  { listaToken = insereNaLista(listaToken, yytext, "simbolo_parentesesDireita", "\0", linha); }

{CHAVES_dir} { listaToken = insereNaLista(listaToken, yytext, "simbolo_chavesDireita", "\0", linha); }
{CHAVES_esq} { listaToken = insereNaLista(listaToken, yytext, "simbolo_chavesEsquerda", "\0", linha); }

{COLCHETES_esq} { listaToken = insereNaLista(listaToken, yytext, "simbolo_colchetesEsquerda", "\0", linha); }
{COLCHETES_dir} { listaToken = insereNaLista(listaToken, yytext, "simbolo_colchetesDireita", "\0", linha); }

{IGUAL}            { listaToken = insereNaLista(listaToken, yytext, "comparador_igual", "\0", linha); }
{MAIOR_OU_IGUAL}   { listaToken = insereNaLista(listaToken, yytext, "comparador_maiorOuIgual", "\0", linha); }
{MENOR_OU_IGUAL}   { listaToken = insereNaLista(listaToken, yytext, "comparador_menorOuIgual", "\0", linha); }
{DIFERENTE}        { listaToken = insereNaLista(listaToken, yytext, "comparador_diferente", "\0", linha); }
{MAIOR}            { listaToken = insereNaLista(listaToken, yytext, "comparador_maior", "\0", linha); }
{MENOR}            { listaToken = insereNaLista(listaToken, yytext, "comparador_menor", "\0", linha); }


{IDENTIFICADOR} {
    listaToken = insereNaLista(listaToken, yytext, "id", "\0", linha);
}

{ERROVARIAVEL} {
    printf("Token: %s\nTipo de token: %s\nErro: %s\nLinha: %d\n\n", yytext, "variavel", "formato errado", linha);
}


{ERRONUM} {
    printf("Token: %s\nTipo de token: %s\nErro: %s\nLinha: %d\n\n", yytext, "numero", "formato errado", linha);
}

. {
    printf("Token: %s\nTipo de token: ponto\nErro: caractere invalido\nLinha: %d\n\n", yytext, linha);
}

{ERROCADEIA} {
    printf("Token: %s\nTipo de token: string\nErro: string malformada (aspas nao fechadas)\nLinha: %d\n\n", yytext, linha);
}





"\n" { linha++; }

%%




FILE* abrirArquivo(){
    char nomeArquivo[100];
    printf("Digite o nome do arquivo.\n");
    scanf("%[^\n]%*c", nomeArquivo);
    printf("\n\n");
    return fopen(nomeArquivo, "r");
}


int main() {
    printf("\nBEM VINDOS A PORTULANG\n\n");
    int opcao;

    while (1) {
        printf("\nEscolha uma das opcoes: \n");
        printf("1 - Carregar arquivo \n");
        printf("0 - Sair \n");
        scanf("%d%*c", &opcao);

        switch (opcao) {
            case 1:
                yyin = abrirArquivo();
                yylex();  

                int opcao2;
                printf("\nDeseja mostrar os lexemas corretos?\n");
                printf("1 - sim\n");
                printf("0 - nao\n\n");
                scanf("%d%*c", &opcao2);

                switch (opcao2) {
                    case 1:
                        analiseLexica(listaToken); 
                        break;
                    case 0:
                        printf("Voltando ao menu principal...\n");
                        break;
                    default:
                        printf("Opcao invalida. Voltando ao menu.\n");
                        break;
                }

                linha = 1;
                esvaziarLista(listaToken);
                break;

            case 0:
                printf("Encerrando o programa.\n");
                return 0;

            default:
                printf("Opcao invalida. Tente novamente.\n");
                break;
        }
    }
}
