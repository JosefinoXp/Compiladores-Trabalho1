#ifndef TOKENS_H
#define TOKENS_H

#define TAM 100

//estrutura do token
typedef struct no {
    char nome[TAM];        // lexema reconhecido - o token em si
    int linha;             // número da linha do token
    char token[TAM];       // tipo do token 
    char tipo_erro[TAM];   // descrição do erro se tiver
    struct no* prox;       
} TokenList;

// variável global apontando pra o inicio da lista de tokens
extern TokenList* listaToken;
// foi usado extern para evitar multiplas declarações pois ja está sendo declarado no tokens.c

// insere um novo token ou erro na lista encadeada
TokenList* insereNaLista(TokenList* listaToken, char* nome, char* token, char* tipo_erro, int l);

// libera a memória ocupada pela lista
void esvaziarLista(TokenList* listaToken);

// percorre a lista e imprime os tokens reconhecidos incluindo os erros
void analiseLexica(TokenList* listaToken);

#endif
