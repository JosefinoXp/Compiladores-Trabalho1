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

COMENTARIO "//".*

%%


" "          { }


{ESPECIFICADORDEFORMATO} {
    listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "especificador_de_formato", "\0", linha);
}


{VIRGULA} {
    listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "simbolo_virgula", "\0", linha);
}


{E_COMERCIAL} {
    listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "operador_endereco", "\0", linha);
}


{CADEIA} {
    listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "cadeia", "\0", linha);
}

{ERRO_DECIMAL_VIRGULA} {
    printf("Token: %s\nTipo de token: numero\nErro: numeros decimais nao podem usar virgula\nLinha: %d\n\n", yytext, linha);
}


{MAIN}     { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "funcao_inicio", "\0", linha); }
{RETURN}   { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "palavraChave_retorno", "\0", linha); }
{REMOVE}   { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "palavraChave_remove", "\0", linha); }
{INCLUDE}  { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "palavraChave_inclua", "\0", linha); }
{DEFINE}   { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "palavraChave_defina", "\0", linha); }

{IF}       { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "condicional_se", "\0", linha); }
{ELSE}     { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "condicional_senao", "\0", linha); }
{SWITCH}   { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "condicional_compare", "\0", linha); }
{CASE}     { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "condicional_caso", "\0", linha); }

{FOR}      { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "repeticao_para", "\0", linha); }
{WHILE}    { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "repeticao_enquanto", "\0", linha); }
{DO}       { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "repeticao_faca", "\0", linha); }
{BREAK}    { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "repeticao_pare", "\0", linha); }

{PRINTF}   { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "funcao_imprima", "\0", linha); }
{SCANF}    { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "funcao_escaneie", "\0", linha); }

{SIZEOF}   { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "funcao_tamanhoDe", "\0", linha); }
{MALLOC}   { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "funcao_aloca", "\0", linha); }

{STRUCT}   { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "tipo_estrutura", "\0", linha); }
{VOID}     { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "tipo_vazio", "\0", linha); }
{INT}      { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "tipo_inteiro", "\0", linha); }
{FLOAT}    { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "tipo_decimal", "\0", linha); }
{DOUBLE}   { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "tipo_real", "\0", linha); }
{CHAR}     { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "tipo_caractere", "\0", linha); }

{ADD}        { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "operador_adicionar", "\0", linha); }
{SUB}        { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "operador_subtrair", "\0", linha); }
{ATRIB}      { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "operador_atribuicao", "\0", linha); }
{DIVISAO}    { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "operador_divisao", "\0", linha); }
{MULTIPLICACAO} { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "operador_multiplicacao", "\0", linha); }
{RESTO}      { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "operador_resto", "\0", linha); }

{AND}        { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "operador_e", "\0", linha); }
{OR}         { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "operador_ou", "\0", linha); }
{NOT}        { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "operador_nao", "\0", linha); }

{PARENTESES_ESQUERDA} { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "simbolo_parentesesEsquerda", "\0", linha); }
{PARENTESES_DIREITA}  { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "simbolo_parentesesDireita", "\0", linha); }

{CHAVES_dir} { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "simbolo_chavesDireita", "\0", linha); }
{CHAVES_esq} { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "simbolo_chavesEsquerda", "\0", linha); }

{COLCHETES_esq} { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "simbolo_colchetesEsquerda", "\0", linha); }
{COLCHETES_dir} { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "simbolo_colchetesDireita", "\0", linha); }

{IGUAL}            { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "comparador_igual", "\0", linha); }
{MAIOR_OU_IGUAL}   { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "comparador_maiorOuIgual", "\0", linha); }
{MENOR_OU_IGUAL}   { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "comparador_menorOuIgual", "\0", linha); }
{DIFERENTE}        { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "comparador_diferente", "\0", linha); }
{MAIOR}            { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "comparador_maior", "\0", linha); }
{MENOR}            { listaPalavraReservadaToken = insereNaLista(listaPalavraReservadaToken, yytext, "comparador_menor", "\0", linha); }


{IDENTIFICADOR} {
    listaSimboloToken = insereNaLista(listaSimboloToken, yytext, "id", "\0", linha);
}

{NUMERO}   { 
    listaSimboloToken = insereNaLista(listaSimboloToken, yytext, "numero", "\0", linha); 
}

\"[^\"]*\" {
    listaSimboloToken = insereNaLista(listaSimboloToken, yytext, "texto", "\0", linha);
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




{COMENTARIO} { }

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
                        printf("\n\n\t TABELA DE PALAVRAS RESERVADAS \t\n\n");
                        analiseLexica(listaPalavraReservadaToken);
                        printf("\t TABELA DE SIMBOLOS \t\n"); 
                        analiseLexica(listaSimboloToken);
                        break;
                    case 0:
                        printf("Voltando ao menu principal...\n");
                        break;
                    default:
                        printf("Opcao invalida. Voltando ao menu.\n");
                        break;
                }

                linha = 1;
                esvaziarLista(listaPalavraReservadaToken);
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
