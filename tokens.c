#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "tokens.h"

TokenList* listaPalavraReservadaToken = NULL;
TokenList* listaSimboloToken = NULL;

// função que insere um novo token na lista encadeada de tokens
TokenList* insereNaLista(TokenList* listaToken, char* nome, char* token, char* tipo_erro, int linha) {

    // aloca dinamicamente um novo nó (token)
    TokenList* no = (TokenList*)malloc(sizeof(TokenList));

    // copia os dados recebidos para o novo nó
    strcpy(no->nome, nome);               // token em si
    strcpy(no->token, token);             // tipo de token 
    strcpy(no->tipo_erro, tipo_erro);     // tipo de erro, se houver
    no->linha = linha;                    // linha do token

    if(listaToken == NULL){
        no->prox = NULL;
        listaToken = no;
    } else {
        // Caso contrário, percorre a lista até o final para inserir o novo nó no fim
        TokenList* aux = listaToken;
        while(aux->prox != NULL){
            aux = aux->prox;
        }
        no->prox = NULL;
        aux->prox = no;
    }

    // retorna a lista atualizada 
    return listaToken;
}


//função recursiva que imprime o conteúdo da lista de tokens
void analiseLexica(TokenList* listaToken){

    if(listaToken != NULL){

        // verifica se o token possui erro
        if(strlen(listaToken->tipo_erro) != 0){
            printf("Token: %s\nTipo do token: %s\nErro: %s\nLinha: %d\n\n",
                   listaToken->nome, listaToken->token, listaToken->tipo_erro, listaToken->linha);
        } else {
            // se nao tem erro ele printa normalmente
            printf("Token: %s\nTipo do token: %s\nLinha: %d\n\n",
                   listaToken->nome, listaToken->token, listaToken->linha);
        }

        // chama a função pro proximo nó
        analiseLexica(listaToken->prox);
    }
}


//função que libera a memória alocada
void esvaziarLista(TokenList* listaToken) {

    TokenList* atual = listaToken;

    while(atual != NULL){

        TokenList* proximo = atual->prox;  
        free(atual);                     
        atual = proximo;      

    }
}


