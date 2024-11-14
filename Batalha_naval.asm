
title teste de impressao
.model small

push_all macro
             push ax
             push BX
             push cx
             push Dx
             push si
             push di
endm

pop_all macro
            pop di
            pop si
            pop dx
            pop cx
            pop bx
            pop ax
endm

move_XY macro x,y            ;Macro para pocionar o cursor numa posicao desejada

            push_all

            mov      ah,2
            mov      dh,y
            mov      dl,x
            int      10h

            pop_all
endm

desenha_Quadrado macro a,b

                     push_all

                     move_XY  a,b               ;35,2
                     lea      si,quadrado
                     call     imprime_Letras
                     
                     pop_all

endm

.stack 100h
.data
    ;---------------------------MENSAGENS_DE_INTRODUCAO-------------------------------------------------------------------------------------------;
    MSGINTRO1                        db "Bem vindo ao jogo de batalha naval! $"
    MSGINTRO2                        db "Regras para jogar: $"
    MSGINTRO3                        db "Terao de ser inseridos 1 encouracado, 1 fragata, 2 submarinos e 2 hidroavioes $"
    MSGINTRO4                        db "Encourada -> Ocupa 4 posicoes em linha reta $"
    MSGINTRO5                        db "Fragata -> 3 posicoes em linha reta $"
    MSGINTRO6                        db "Submarino -> 2 posicoes em linha reta $"
    MSGINTRO7                        db "Hidroaviao -> 3 posicoes em linha reta e uma na horizonta no meio dessas $"
    MSGINTRO8                        db "O jogador deve posicionar cada embarcacao com uma distancia minima de uma casa $"
    MSGINTRO9                        db "Ganha quem acertar o todos os navios do openente $"
    MSGINTRO10                       db "Pressione qualquer tecla para continuar! $"
    MSGINVALIDO                      db "A posicao digitada eh invalida. $"

    quebra_Linha                     db 10,13,"$"
    ;------------------------------------------Mensagens-------------------------------------------------------------------------------------------------;
    MSGPEGARNOME                     db "Digite o seu nome: $"
    MSGENCOURADO                     db "Comece digitando a posicao do ENCOURADO: $"
    MSGFRAGATA                       db "Digite a posicao do FRAGATA: $"
    MSGSUBMARINO                     db "Digite a posicao do SUBMARINO: $"
    MSGHIDROAVIAO                    db "Digite a posicao do HIDROAVIAO: $"
    MSGLEMBRESE1                     db "Lembre-se o encourado ocupa 4 posicoes, como a seguir: $"
    MSGLEMBRESE_FRAGATA              db "Lembre-se, o fragata ocupa 3 posicoes como a seguir: $"
    MSGLEMBRESE_SUBMARINO            db "Lembre-se, o Subamarino ocupa 2 posicoes, como a seguir: $"
    MSGLEMBRESE_HIDROAVIAO           db "Lembre-se, o hidroaviao ocupa 4 posicoes, como a seguir: $"
    MSGPEGAPOSICAO                   db "Digite a posicao desejada$"
    MSGPEGAPOSICAO2                  db "para embarcacao:$"
    MSGPOSICAOOPONENTE1              db "Agora, o Computador ira alocar a posicao de suas embarcacoes $"
    MSGPOSICAOOPONENTE2              db "Serao posicionadas as mesmas embarcacoes anteriores $"
    MSGPOSICAOOPONENTE3              DB "Pressione qualquer tecla, a cada embarcacao $"
    MSGPOSICAOOPONENTE4              DB "para liberar o pc para posiciona-la $"
    MSGPOSICAOOPONENTE5              DB "PRESSIONE QUALQUER TECLA PARA CONTINUCAR $"
    MSGATENCAO                       DB "ATENCAO:$"
    MSGALENCOURADO                   DB "Agora, libere o computador para posicionar o ENCOURADO $"
    MSGALFRAGATA                     DB "Agora, libere o computador para posicionar a FRAGATA $"
    MSGALSUBMARINO                   DB "Agora, libere o computador para posicionar o SUBMARINO $"
    MSGALHIDROAVIAO                  DB "Agora, libere o computador para posicionar o HIDROAVIAO $"
    MSGINIATAQUE                     DB "Agora, vamos comecar a guerra!$"
    MSGINIATAQUE2                    DB "Voce devera digitar a posicao que deseja atacar$"
    MSGINIATAQUE3                    DB "Apos voce atacar, descobrira se acertou ou nao uma embarcacao$"
    MSGINIATAQUE4                    DB "Apos o seu ataque, o computador ira te atacar tambem!$"
    MSGINIATAQUE5                    DB "Finalmente, voce vera se ele acertou alguma embarcacao tambem$"
    MSGINIATAQUE6                    DB "Ganha quem derrubar todas as embarcacoes primeiro!$"
    MSGINIATAQUE7                    DB "BOA GUERRA!$"
    MSGSUAVEZ                        DB "SUA VEZ DE ATACAR!$"
    MSGATAQUE                        DB "Abaixo, digite a posicao que deseja atacar$"
    MSGATAQUE2                       DB "Insira a posicao de ataque:$"
    MSGACERTOU                       DB "Voce atingiu uma embarcacao!$"
    MSGERROU                         DB "Voce errou o tiro!$"
    MSGPCATAQUE                      DB "Vez do PC atacar!$"
    MSGPCATAQUE2                     DB "A posicao ataca pelo pc foi:$"
    MSGPCACERTOU                     DB "O PC acertou sua embarcacao!$"
    MSGPCERROU                       DB "O PC errou o seu tiro!$"
    MSGINVALIDOATAQUE                DB "Voce ja atacou essa posicao antes$"
    
    ;&=padrao estabelecido para quebra de linhas na funcao de imprir criada
    ;--------------------------------------Declaracao das matrizes que serao utilizadas como tabuleiro-------------------------------------------------------------------------------------;
    matriz_Jogador                   db 10 dup (9 dup (0)),"$"
    matriz_Adversario                db 10 dup (9 dup(0)),"$"
    matriz_Controle_Jogador          db 10 dup (9 dup (0)),"$"
    matriz_Controle_Adversario       db 10 dup (9 dup (0)),"$"
    colunas                          db "[0] [1] [2] [3] [4] [5] [6] [7] [8] [9] $"
    linhas                           db "A B C D E F G H I$"
    DIV_1                            DB 218,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,191,"$"    ;Usando codigos ASCII para impressao
    DIV_2                            DB 192,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,217,"$"    ;das matrizes utilizadas no jogo
    DIV_3                            DB 195,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,180,"$"
    DIV_4                            DB 179, 10 dup (3 dup (" "), 179), "$"
    quadrado                         db 219,219,"$"
    lateral_Direita                  dw 9,19,29,39,49,59,69,79,89,"$"
    ;--------------------------------------Variaveis de ambiente-------------------------------------------------------------------------------------------------------------------;

    nome_Jogador                     db 15 dup (?)
    posicao_Desejada                 db ?,?
    posicao_Desejada_Decifrada       db ?,"$"
    posicao_anterior                 dw 0
    cx_inicial                       dw ?
    resultado_Sorteio_1              db ?
    resultado_Sorteio_2              db ?
    posicao_Valida                   db ?
    posicao_hidroaviao               db 0
    eh_Hidroaviao                    db 0
    contagem_Reposicionamentos       dw 0
    contagem_Reposicionamentos_Hidro dw 0
    reiniciar                        db 0
    posicao_Ataque                   db ?,?
    posicao_Ataque_Decifrada         db ?
    deu_Errado                       db 0
    ganhou                           db ?
    primeira_Tentativa_Ataque        db 1
    ;-----------------------------------------------------------------------------------------------------------------------------------------------------------------;
.code

main proc

                                      mov              ax,@data
                                      mov              ds,ax                                     ;Libera acesso ao .DATA

    ;------------------------------------------------------TELA_INCIAL--------------------------------------------------------------------------;

                                      call             limpa_Tela

                                      move_XY          25,0                                      ;Coloca o cursor no centro da tela

    
    ;call             imprimir_Introducao               ;Imprime a introdução e fica travado até apertar alguma tecla

    ;call             limpa_Tela                        ;Limpa tela apos sair da proc de cima

    ;call             pega_Nome                         ;Pega o nome do jogador

    ;call             limpa_Tela                        ;Limpa a tela

    ;call             Imprime_tabuleiro                 ;Começa a posiconar os navios

    ;call             posiciona_Navios

    ;call             tela_Posicionamento_Oponente

    ;call             limpa_Tela

    ;call             imprime_Tabuleiro

    ;call             posiciona_Navios_Aleatorio

    ;lea              si,matriz_Adversario

    ;call             imprime_Tabuleiro

    ;call             posiciona_Posicao

    ;mov              ah,1
    ;int              21h

                                      call             limpa_Tela

                                      call             tela_Inicio_Ataque

                                      call             ataque
    
    ;---------------------------------FIM_DO_PROGRAMA--------------------------------------------------------------------------------------;
    
                                      jmp              fim

    ;--------------------------------Procedimentos:----------------------------------------------------------------------------------------;
    
limpa_Tela proc                                                                                  ;Procedimento que limpa a tela:

                                      push_all

                                      MOV              AH,0
                                      MOV              AL,3
                                      INT              10H

                                      pop_all

                                      ret


limpa_Tela endp

                
    ;------------------------------------------------------------------------------------------------------------------------------------;
imprime_Letras proc                                                                              ;Procedimento para impressao de caracters
    ;Necessário enviar BL e si ( BL = cor e si = endereço do caracter )
    ;O caracter & sera reconhecido como um comando para quebrar linha

                                      push_all

                                      MOV              BH, 00h                                   ; Número da página de vídeo (geralmente 00h)


    impressao_Loop:                   

                                      cmp              dl,"&"
                                      je               pular_Impressao
                            
                                      mov              al,[si]
                                      MOV              AH, 09h                                   ; Função para escrever caractere e atributo
                                      MOV              CX, 1                                     ; Número de vezes para escrever o caractere
                                      INT              10h                                       ; Chama a interrupção de vídeo

                                      mov              ah,3                                      ;dh=linha dl=coluna
                                      int              10h
                                      inc              dl
                                      mov              ah,2                                      ;Passa o curso uma posicao para o lado
                                      int              10h

                                      inc              si
                                      mov              dl,[si]
                                      cmp              dl,"$"
                                      jz               fim_Impressao_Letra                       ;Compara para ver se já terminou a
                                      jmp              impressao_Loop

    pular_Impressao:                  

                                      inc              si
                                      call             pula_Linha
                                      mov              dl,[si]
                                      cmp              dl,"$"
                                      jz               fim_Impressao_Letra                       ;Compara para ver se já terminou a
                                      jmp              impressao_Loop
                            



    fim_Impressao_Letra:              
                            
                                      call             pula_Linha                                ;Passa para a próxima linha dps da impressao

                                      pop_all

                                      ret

imprime_Letras endp

imprime_Letras_Vertical proc

    ;Necessário enviar BL e si ( BL = cor e si = endereço do caracter )

                                      push_all

                                      MOV              BH, 00h                                   ; Número da página de vídeo (geralmente 00h)


    impressao_Loop_Vertical:          

                                      mov              al,[si]
                                      MOV              AH, 09h                                   ; Função para escrever caractere e atributo
                                      MOV              CX, 1                                     ; Número de vezes para escrever o caractere
                                      INT              10h                                       ; Chama a interrupção de vídeo

                                      mov              ah,3                                      ;dh=linha dl=coluna
                                      int              10h
                                      inc              dh
                                      mov              ah,2                                      ;Passa o curso uma posicao para o lado
                                      int              10h

                                      inc              si
                                      mov              dl,[si]
                                      cmp              dl,"$"
                                      jnz              impressao_Loop_Vertical                   ;Compara para ver se já terminou a string

                                      call             pula_Linha                                ;Passa para a próxima linha dps da impressao

                                      pop_all

                                      ret

imprime_Letras_Vertical endp

pula_Linha proc

                                      push_all

                                      mov              ah,9
                                      lea              dx,quebra_Linha
                                      int              21h

                                      pop_all

                                      ret
pula_Linha endp

imprimir_Introducao proc

                                      push_all

                                      MOV              BL, 0ch                                   ; Atributo de cor (0ch = texto vermelho)
                                      lea              si,msgintro1
                                      call             imprime_Letras

                                      call             pula_Linha

                                      MOV              BL, 0eh                                   ; Atributo de cor (0Eh = texto amarelo)
                                      lea              si,msgintro2
                                      call             imprime_Letras

                                      call             pula_Linha

                                      lea              si,msgintro3
                                      call             imprime_Letras

                                      lea              si,msgintro4
                                      call             imprime_Letras

                                      lea              si,msgintro5
                                      call             imprime_Letras

                                      lea              si,msgintro6
                                      call             imprime_Letras

                                      lea              si,msgintro7
                                      call             imprime_Letras

                                      lea              si,msgintro8
                                      call             imprime_Letras

                                      lea              si,msgintro9
                                      call             imprime_Letras

                                      mov              bl,0bh
                                      ADD              BL,128                                    ;Faz ficar piscando
                                      lea              si,msgintro10
                                      move_XY          22,12
                                      call             imprime_Letras

                                      mov              ah,1
                                      int              21h

                                      pop_all

                                      ret

imprimir_Introducao endp

pega_Nome proc

                                      push_all

                                      move_XY          30,5
                                      lea              si,MSGPEGARNOME
                                      mov              bl,0ah
                                      call             imprime_Letras

                                      mov              ah,1
                                      lea              si,nome_Jogador
                                      move_XY          36,6
    loop_Letras:                      

                                      int              21h
                                      cmp              al,13
                                      je               fim_Loop
                                      mov              [si],al
                                      inc              si
                                      jmp              loop_Letras

                        
    fim_Loop:                         
                                      mov              bx,"$"
                                      mov              [si],bx

                                      pop_all

                                      ret

pega_Nome endp

Imprime_tabuleiro proc

                                      push_all
    ;;
                                      move_XY          36,5
                                      lea              si,colunas
                                      mov              bl,3h
                                      call             imprime_Letras

                                      move_XY          33,7
                                      lea              si,linhas
                                      call             imprime_Letras_Vertical

                                      move_XY          35,5
                                      mov              bl,0Fh
                                      lea              si,div_1
                                      call             imprime_Letras
                                      move_XY          35, 6
                                      lea              si, div_4
                                      call             imprime_Letras

                                      mov              Dx, 7
                                      mov              cx,8
    Imprime_meio:                     
                                      move_XY          35,dl
                                      lea              si, DIV_3
                                      call             imprime_Letras
                                      inc              dx
                                      move_XY          35,dl
                                      lea              si, div_4
                                      call             imprime_Letras
                                      inc              dx
                                      loop             Imprime_meio
                    

                                      move_XY          35, 21
                                      lea              si, DIV_3
                                      call             imprime_Letras

                                      move_XY          35, 22
                                      lea              si, div_4
                                      call             imprime_Letras

                                      move_XY          35, 23
                                      lea              si, DIV_2
                                      call             imprime_Letras

                                      pop_all

                                      ret

Imprime_tabuleiro endp

pega_Posicao proc                                                                                ;Procedimento para pegar a posicao que o jogador deseja posicionar suas embarcacoes
    ;Tem que passar cx com a quantidade de vezes que quer rodar
                                      push_all
                                      xor              dx,dx
                                      mov              dx,6                                      ;Valores para o posicionamento das mensagens na tela
                                      mov              cx_inicial,cx
    loop_Inteiro:                     

                                      lea              si,msgpegaposicao
                                      move_XY          2,dl
                                      inc              dx
                                      call             imprime_Letras                            ;Imprime a primeira parte da mensagem

                                      lea              si,msgpegaposicao2
                                      move_XY          7,dl
                                      call             imprime_Letras                            ;Quebra linha e imprime a segunda parte
                                      inc              dx

    ;IMRPIMIU AS MSGS

                                      push             cx                                        ;Guarda o cx antigo
                                      mov              cx,2                                      ;Atualiza o cx para pegar as duas cordenadas desejadas
                                      lea              di,posicao_Desejada                       ;Passa a posicao de memoria para di de onde vamos armazenar as cordenadas
                                      move_XY          14,dl                                     ;Posiciona o cursor
    loop_Pega_Posicao:                

                                      mov              ah,1
                                      int              21h                                       ;Salva em AL o que foi digitado pelo usuario

                                      mov              [di],al
                                      inc              di                                        ;Passa para a variavel a posicao inserida

                                      loop             loop_Pega_Posicao                         ;Roda duas vezes


    ;Posicao desejada contem a posicao que o jogador inseriu, verificar se a posicao é possivel




                                      pop              cx                                        ;Volta para o cx antigo
                                      inc              dx                                        ;Atualiza a posicao do cursor


                                      call             decifra_Posicao                           ;Decifra qual posicao da matriz tem que ser alterada

                                      loop             loop_Inteiro                              ;Loop para pegar todas as posicoes necessarias para embarcacao

                                      pop_all
                                      ret                                                        ;Retorna para onde estava
pega_Posicao endp

verifica_Posicao proc
                                      push_all

                                      cmp              posicao_hidroaviao,1
                                      je               verifica_hidroaviao
    continua:                         
                                      xor              dx, dx
                                      mov              bx,di                                     ;move o offset da posição digitada para bx

                                      sub              bx,11                                     ;a partir desse ponto o porgrama vai somando o conteudo do offset das posicoes que estao em volta da posição digitada
                                      add              dl,[bx]

                                      inc              bx
                                      add              dl,[bx]

                                      inc              bx
                                      add              dl,[bx]

                                      add              bx,8
                                      add              dl,[bx]

                                      add              bx, 2
                                      add              dl,[bx]

                                      add              bx,8
                                      add              dl,[bx]

                                      inc              bx
                                      add              dl,[bx]

                                      inc              bx
                                      add              dl,[bx]

                                      cmp              cx,cx_inicial
                                      jz               primeira_vez                              ;verifica se a label esta sendo rodada pela primeira vez

                                      cmp              dx,1
                                      jnz              posicao_Aprovada                          ;verifica se há duas posicoes setadas em volta da posicao digitada, pois a partir da segunda posicao do barco sempre terá pelo menos uma posicao setada e volta da digitada
                                      jmp              liberado

    primeira_vez:                     
                                      cmp              dx,0                                      ;garante que a primeira posição do barco tenha distancia de pelo menos 1 casa de qualquer embarcação
                                      jnz              posicao_Aprovada

    liberado:                         
    ;DI vai chegar com os valor da posicao absoluta atual digitada
    ;posicao_Anterior guarda a posicao absoluta anterior (tudo em offset)


                                      cmp              cx,cx_inicial
                                      je               posicao_Aprovada                          ;Primeira vez que está rodando, então nao precisa verficar

                                      xor              dx,dx
                                      mov              dx,posicao_Anterior


                                      inc              dx
                                      cmp              dx,di
                                      jz               posicao_Aprovada

                                      sub              dx,2
                                      cmp              dx,di
                                      jz               posicao_Aprovada

                                      add              dx,11
                                      cmp              dx,di
                                      jz               posicao_Aprovada

                                      sub              dx,20
                                      cmp              dx,di
                                      jz               posicao_Aprovada
    ;Passou aqui -> posicao rejeitada



                           
    posicao_Aprovada:                 
                                      pop_all
                                      ret
    verifica_hidroaviao:              

                                      cmp              cx,cx_inicial
                                      je               liberado

                                      cmp              cx,1
                                      jne              continua

                                      cmp              di,posicao_Anterior
                                      jg               apos

                                      mov              bx,posicao_Anterior
                                      sub              bx,di

                                      cmp              bx,9
                                      jz               posicao_Aprovada

                                      cmp              bx,11
                                      jz               posicao_Aprovada
                                      jmp              posicao_Aprovada

    apos:                             
    
                                      mov              bx,di
                                      sub              bx,posicao_Anterior
                                   
                                
                                      cmp              bx,9
                                      jz               posicao_Aprovada

                                      cmp              bx,11
                                      jz               posicao_Aprovada
                                      jmp              posicao_Aprovada

verifica_Posicao endp


decifra_Posicao proc
                                      push_all
    ;cx com quantas vezes ja rdou
                                      xor              ax,ax
                                      mov              al,10                                     ;Coluna vale como 10 posicoes
                            
                                      lea              si, posicao_Desejada                      ;Passa o endereço da variavel
                                      sub              byte ptr [si], 65                         ;Trasforma a letra para o numero corespondente da linha desejada
                            
                                      mul              byte ptr [si]                             ;Coluna conta como 10 posicoes
                            
                                      inc              si
                                      sub              byte ptr[si],48                           ;Transforma o caracter do numero para apenas o numero

                                      add              ax,[si]                                   ; Salva em AX a multipliacap de [si+1] com [si] (salvo em ax anteriormente)

    ;Ax está com a posição absoluta desejada

                                      lea              di,matriz_Controle_Jogador
                                      add              di,ax                                     ;Passa para a matriz o valor 1 na posicao desejada
    ;calma

                                      call             verifica_Posicao                          ;Passa para DI com a posicaod da memoria que desejamso alterar ( offset matriz + Posicao desejada )
                                      jnz              errado

                                      mov              byte ptr [di],1
                            
                                      mov              posicao_anterior, di

                                      lea              si,matriz_Controle_Jogador                ;Passa como parametro para o procedimento a matriz que tem q ser impressa
                                      call             posiciona_Posicao

                                      jmp              final
    errado:                           
    ;call             pula_Linha
                                      lea              si, MSGINVALIDO
                                      mov              ah, 3
                                      int              10h
                                      move_XY          2, dh
                                      call             imprime_Letras
                                      pop_all
                                      inc              cx
                                      ret
    final:                            
                                      pop_all
                                      ret
decifra_Posicao endp

posiciona_Posicao proc                                                                           ;Tem que receber em si o endereço da matriz

                                      push_all

                                      xor              cx,cx
                                      mov              cx,0

    roda_Matriz:                      

                                      cmp              cx,90
                                      je               fim_1
                                      inc              cx

                                      xor              dx,dx
                                      mov              dl,[si]
                                      inc              si
                                      cmp              dl,1
                                      jne              roda_Matriz                               ;-> virar call
                            
                                      call             imprime_Posicao

                                      jmp              roda_Matriz


    fim_1:                            
                                      pop_all
                                      ret

posiciona_Posicao endp

imprime_Posicao proc


                                      push_all

                            
                                      xor              ax,ax
                                      xor              dx,dx                                     ;Limpa registradores

                                      dec              cx
                                      mov              al,cl

                                      mov              cl,10
                                      div              cl                                        ;Divide Al por Cl e salva resultado em AL e resto em AH
                                      xor              bx,bx
                                      mov              bl,ah                                     ;salva em BL o resto

                                      xor              dx,dx
                                      mov              cl,2
                                      mul              cl
                                      push             ax                                        ;Multiplica o resultado por 2 dando a quantidade de linhas para baixo

                                      xor              ax,ax
                                      mov              al,bl
                                      mov              cl,4
                                      mul              cl
                                      xor              bx,bx                                     ;Multiplica o resto por 4 para dar a quantidade de colunas para o lado
                                      mov              bx,ax

                                      pop              dx

                                      add              dx,6
                                      add              bx,37

                                      move_XY          bl,dl

                                      xor              ax,ax
                                      mov              ah,2
                                      xor              dx,dx
                                      mov              dl,"1"
                                      int              21h

                                      pop_all


                                      ret

imprime_Posicao endp

posiciona_Navios proc
                                      push_all

                                      move_XY          20,0
                                      lea              si,MSGENCOURADO
                                      mov              bl,0Bh
                                      call             imprime_Letras

                                      move_XY          14,1
                                      mov              bl,0fh
                                      lea              si,msglembrese1
                                      call             imprime_Letras

                                      mov              cx,4
                                      xor              dx,dx
                                      mov              dx,34

    loop_Desenha_Encourado:           
                                      desenha_Quadrado dl,2
                                      add              dx,3
                                      loop             loop_Desenha_Encourado
    
                                      mov              cx,4                                      ;Passar quantas posicoes precisao ser pegas
                                      call             pega_Posicao

    ;COMEÇA PROXIMO NAVIO

                                      call             limpa_Tela

                                      move_XY          24,1
                                      lea              si,MSGFRAGATA
                                      mov              bl,0Bh
                                      call             imprime_Letras

                                      move_XY          14,2
                                      lea              si,MSGLEMBRESE_FRAGATA
                                      mov              bl,0Fh
                                      call             imprime_Letras
                            
                                      mov              cx,3
                                      xor              dx,dx
                                      mov              dx,34
    loop_Desenha_Fragata:             
                                      desenha_Quadrado dl, 3
                                      add              dx,3
                                      loop             loop_Desenha_Fragata

                                      call             Imprime_tabuleiro
                                      lea              si,matriz_Controle_Jogador                ;Passa como parametro para o procedimento a matriz que tem q ser impressa
                                      call             posiciona_Posicao

                            

                                      mov              cx,3
                                      call             pega_Posicao

    ;Proximo (Submarino = 2x)


                                      call             limpa_Tela

                                      move_XY          24,1
                                      lea              si,MSGSUBMARINO
                                      mov              bl,0Bh
                                      call             imprime_Letras

                                      move_XY          14,2
                                      lea              si,MSGLEMBRESE_SUBMARINO
                                      mov              bl,0Fh
                                      call             imprime_Letras
                            
                                      mov              cx,2
                                      xor              dx,dx
                                      mov              dx,34
    loop_Desenha_Submarino1:          
                                      desenha_Quadrado dl, 3
                                      add              dx,3
                                      loop             loop_Desenha_Submarino1

                                      call             Imprime_tabuleiro
                                      lea              si,matriz_Controle_Jogador                ;Passa como parametro para o procedimento a matriz que tem q ser impressa
                                      call             posiciona_Posicao

                            

                                      mov              cx,2
                                      call             pega_Posicao



                                      call             limpa_Tela

                                      move_XY          24,1
                                      lea              si,MSGSUBMARINO
                                      mov              bl,0Bh
                                      call             imprime_Letras

                                      move_XY          14,2
                                      lea              si,MSGLEMBRESE_SUBMARINO
                                      mov              bl,0Fh
                                      call             imprime_Letras
                            
                                      mov              cx,2
                                      xor              dx,dx
                                      mov              dx,34
    loop_Desenha_Submarino2:          
                                      desenha_Quadrado dl, 3
                                      add              dx,3
                                      loop             loop_Desenha_Submarino2

                                      call             Imprime_tabuleiro
                                      lea              si,matriz_Controle_Jogador                ;Passa como parametro para o procedimento a matriz que tem q ser impressa
                                      call             posiciona_Posicao

                            

                                      mov              cx,2
                                      call             pega_Posicao

                                      call             limpa_Tela

                                      move_XY          24,1
                                      lea              si,MSGHIDROAVIAO
                                      mov              bl,0Fh
 
                                      call             imprime_Letras
                                      move_XY          14,2
                                      lea              si,MSGLEMBRESE_HIDROAVIAO
                                      mov              bl,0Fh
                                      call             imprime_Letras

                                      mov              cx,3
                                      xor              dx,dx
                                      mov              dx,23
    loop_desenha_hidroaviao:          
                                      desenha_Quadrado dl,3
                                      add              dx,3
                                      loop             loop_desenha_hidroaviao

                                      xor              dx,dx
                                      mov              dx,26

                                      desenha_Quadrado dl,5

                                      call             imprime_Tabuleiro
                                      lea              si,matriz_Controle_Jogador
                                      call             posiciona_Posicao

                                      mov              posicao_hidroaviao,1
                                      mov              cx,4
                                      mov              cx_inicial,cx
                                      call             pega_Posicao

                                      call             limpa_Tela

                                      move_XY          24,1
                                      lea              si,MSGHIDROAVIAO
                                      mov              bl,0Fh
 
                                      call             imprime_Letras
                                      move_XY          14,2
                                      lea              si,MSGLEMBRESE_HIDROAVIAO
                                      mov              bl,0Fh
                                      call             imprime_Letras

                                      mov              cx,3
                                      xor              dx,dx
                                      mov              dx,23
    loop_desenha_hidroaviao2:         
                                      desenha_Quadrado dl,3
                                      add              dx,3
                                      loop             loop_desenha_hidroaviao2

                                      xor              dx,dx
                                      mov              dx,26

                                      desenha_Quadrado dl,5

                                      call             imprime_Tabuleiro
                                      lea              si,matriz_Controle_Jogador
                                      call             posiciona_Posicao

                                      mov              posicao_hidroaviao,1
                                      mov              cx,4
                                      mov              cx_inicial,cx
                                      call             pega_Posicao

                                      call             limpa_Tela
    ; nss viado
    ;o mathias ta fazendo esse ???????

                                      pop_all

                                      ret
posiciona_Navios endp

sort_90 proc                                                                                     ;Sorteia um nuemro de 0 a 89 e retorna na variavel Resultado o valor do sorteio

                                      push_all

    ; Chamar a interrupção 1Ah para obter o contador do timer
                                      MOV              AH, 00h
                                      INT              1Ah                                       ; Dx contem o valor do numero aleatorio

                                      mov              cx,90
                                      mov              ax,dx
    ; vamos dividir por 90 para obter um valor de 0 a 89
                                      xor              dx,dx
                                      div              cx                                        ; DX:AX / CX -> AX = quociente, DX = resto


    ; o resto (DX) será nosso número aleatório de 0 a 89

    ; Armazenar o número sorteado na variável resultado
   
                                      mov              resultado_Sorteio_1, dl

                                      pop_all

                                      ret
sort_90 endp

sort_2 proc                                                                                      ;Sorteia um nuemro de 0-3 e retorna na variavel resultado2 o valor do sorteio

                                      push_all

                                      xor              dx,dx

                                      MOV              AH, 00h
                                      INT              1Ah                                       ; Dx contem o valor do numero aleatorio

                                      xor              ax,ax

                                      mov              cx,2
                                      mov              ax,dx
                                      xor              dx,dx
                                      div              cx
               
                                      MOV              resultado_Sorteio_2, dl

                                      pop_all

                                      ret
sort_2 endp

posicona_Posicoes_Aleatorias proc                                                                ;Passar cx com a quantidade de posicoes

    ; Receber posicao da memoria da matriz do computador para poder mecher nela ( em SI )
                                      push_all

                                      mov              contagem_Reposicionamentos,0
                                      mov              contagem_Reposicionamentos_Hidro,0
                                      mov              reiniciar,0

    inicio_Posiciona_Posicoes:        

                                      xor              dx,dx
                                      xor              bx,bx
                                      xor              si,si
                                                            
 
                                      mov              bl,resultado_Sorteio_1
                                      mov              dl,resultado_Sorteio_2
                                      lea              si,matriz_Adversario
                                      add              si,bx                                     ; ( Offset matriz + posicao aleatoria )
    ;Si é oque tem q ser passado para o verefica posicao, so que por DI


                                      mov              cx,cx_inicial

                                      cmp              dx,0                                      ;Vertical
                                      je               Vertical

                                      cmp              dx,1                                      ;Horizontal
                                      je               Horizontal
                                      
    Vertical:                                                                                    ;Verifica se vai caber dentro da matriz

                                      lea              ax,matriz_Adversario

                                      add              ax,30
               
                                      cmp              si,ax

                                      jge              verifica_posicao_concluida
                                 
                                      add              si, 10
                                 
                                      jmp              Vertical
                                 
    verifica_posicao_concluida:       

                                      cmp              eh_Hidroaviao,1
                                      je               hidroAviao_Posiciona

                                      call             verifica_Posicao_aleatoria

                                      cmp              posicao_Valida,0
                                      jne              valido

    ;Passou por aqui precisa reposicionar

    ; inc              contagem_Reposicionamentos
                                      
                                      call             apaga_vertical

                                      jmp              inicio_Posiciona_Posicoes

    valido:                           
                                      mov              byte ptr [si],1

                                      sub              si,10
                                 
                                      loop             verifica_posicao_concluida

                                      jmp              fim_Total

    hidroAviao_Posiciona:             

    ;Se esta aqui eh pq estamos posicionando um hidroaviao
    ;Precisar verificar se a posicao sorteada esta fora da coluna 9

                                      call             verifica_Lateral                          ;Pode ou nao modificar si

                                      call             verifica_Posicao_aleatoria

                                      cmp              posicao_Valida,0
                                      jne              Hidroaviao_valido_Vertical_Inicio

                                      inc              contagem_Reposicionamentos
                                      cmp              contagem_Reposicionamentos,65535
                                      je               renicia_Posicionamento


                                      call             apaga_vertical_Hidroaviao

                                      jmp              inicio_Posiciona_Posicoes

    Hidroaviao_valido_Vertical_Inicio:
                                      mov              byte ptr [si],1

                                      sub              si,10
                                 
                                      loop             hidroAviao_Posiciona

    ;;;;;;;;;;

                                      add              si,10                                     ;Para voltar para ultima posicao posicionada
                                      add              si,11                                     ;Para ir para a posicao que vai ser posicionada a ultima posicao do hidroaviao

    ;Verificar entorno para ver se eh possivel posicionar lá
                                      call             verifica_posicao_Hidroaviao

                                      cmp              posicao_Valida,0
                                      jne              hidro_Valido

                                      inc              contagem_Reposicionamentos_Hidro

                                      call             apaga_Hidroaviao

                                      cmp              contagem_Reposicionamentos_Hidro,65535
                                      je               renicia_Posicionamento                    ;Vai ter q comecar tudo do comeco


                                      jmp              inicio_Posiciona_Posicoes

    hidro_Valido:                     

                                      mov              byte ptr[si],1
                                 
                                      jmp              fim_Total

    Horizontal:                       
                                      xor              bx,bx
                                      xor              ax,ax
                                      mov              al,resultado_Sorteio_1
                                      mov              bl,10
                                      div              bl                                        ;Resto, que esta em ah, tem que ser menor ou igual 6
                                      sub              bx,cx_inicial
                                      cmp              ah,bl
                                      jbe              verifica_posicao_concluida2

                                      mov              al,ah
                                      mov              ah,0
                                      sub              al,bl
                                      sub              si,ax
                                      mov              cx,cx_inicial                             ; ATE AQUI ESTA FUNCIONANDO

    ;Coube na matriz
                                   
    verifica_posicao_concluida2:      
    
                                      call             verifica_Posicao_aleatoria

                                      cmp              posicao_Valida,0
                                      jne              valido2

                                      call             apaga_horizontal

                                      jmp              inicio_Posiciona_Posicoes

    valido2:                          

                                      mov              byte ptr [si],1

                                      inc              si
 
                                      loop             verifica_posicao_Concluida2
                                      jmp              fim_Total

    renicia_Posicionamento:           

                                      mov              reiniciar,1


    fim_Total:                        
                                      pop_all

                                      ret
posicona_Posicoes_Aleatorias endp

apaga_vertical_Hidroaviao proc

                                      push_all

    apaga_Vertical_Loop_Hidro:        

                                      cmp              cx,cx_inicial
                                      je               fim_apaga_Hidro
                                      inc              cx
                                      add              si,10

                                      mov              byte ptr [si],0
                                   
                                
                                      jmp              apaga_vertical_Loop_Hidro

    fim_apaga_Hidro:                  
                                      call             sort_90

                                      pop_all
                                      ret

apaga_vertical_Hidroaviao endp

verifica_Lateral proc                                                                            ;Si esta offset + posicao sorteada

                                      push             ax
                                      push             bx
                                      push             cx
                                      push             dx

                                      xor              bx,bx
                                      xor              di,di
                                      xor              ax,ax

  
                                      lea              ax,matriz_Adversario                      ;ta ok
                                      lea              di,lateral_Direita
                                      sub              si,ax                                     ; 0-89
                                      mov              cx,9
                                      dec              di

    loop_Cmp_Lateral:                 
                                      inc              di
                                      mov              bx,[di]
                                      cmp              si,bx
                                      je               back_1

                                      loop             loop_Cmp_Lateral

                                      add              si,ax

                                      jmp              fim_cmps

    back_1:                           

                                      dec              si
                                      add              si,ax

                                   
    fim_cmps:                         
                                      pop              dx
                                      pop              cx
                                      pop              bx
                                      pop              ax

                                      ret
verifica_Lateral endp

verifica_Posicao_Hidroaviao proc

                                      push_all

    ;SI esta na posicao que deveria ser inserido a ultima posicao do hidroaviao

                                      xor              dx,dx
                                      xor              bx,bx

                                      mov              posicao_valida,1

                                      mov              bx,si
                                      sub              bx,9
                                      add              dx,[bx]

                                      add              bx,10
                                      add              dx,[bx]

                                      add              bx,10
                                      add              dx,[bx]

                                      cmp              dx,0
                                      je               fim_Verifica_Hidro

                                      mov              posicao_Valida,0

    fim_Verifica_Hidro:               
                                      pop_all
                                      ret
verifica_Posicao_Hidroaviao endp

apaga_Hidroaviao proc                                                                            ;Apagar hidroaviao e tentar denovo

                                      push_all

                                      add              si,9
                                      mov              byte ptr[si],0

                                      sub              si,10
                                      mov              byte ptr[si],0

                                      sub              si,10
                                      mov              byte ptr[si],0
    ;Aqui já terminou de apagar o Hidroaviao
    ;Agora tem que sortear denovo

                                      call             sort_90                                   ;Variavel lá ta com a posicao nova
                                      mov              eh_Hidroaviao,1                           ;Garante que a variavel está falando que eh hidroaviao
                                      mov              resultado_Sorteio_2,0                     ;Garante que sera feito na vertical


                                      pop_all
                                      ret
apaga_Hidroaviao endp

apaga_horizontal proc
                                      push_all

    loop_apaga_Horizontal:            
                                      cmp              cx,cx_inicial
                                      je               fim_apaga_horizontal
                                      inc              cx
                                      dec              si

                                  
                                      mov              byte ptr[si],0
                
                                  

                                      jmp              loop_apaga_horizontal

    fim_apaga_horizontal:             

    ; mov              byte ptr[si],0
    ; dec              si

                                      call             sort_90
                                      call             sort_2

                                      pop_all
                                      ret
apaga_horizontal endp

apaga_vertical proc
                                      push_all

    apaga_Vertical_Loop:              

                                      cmp              cx,cx_inicial
                                      je               fim_apaga
                                      inc              cx
                                      add              si,10

                                      mov              byte ptr [si],0
                                   
                                
                                      jmp              apaga_vertical_Loop

    fim_apaga:                        

                                      call             sort_90
                                      call             sort_2

                                      pop_all
                                      ret
apaga_vertical endp

verifica_Posicao_aleatoria proc                                                                  ;Funcionando corretamente e retorna em posicao_Valida se está tudo OK
                                      push_all

                                      mov              posicao_Valida,1

                                      cmp              byte ptr [si],1                           ;se for zero -> posicao invalida
                                      jz               invalido                                  ;se nao for zero -> posicao valida

                                      xor              dx, dx
                                      xor              bx,bx
                                      mov              bx,si                                     ;move o offset da posição digitada para bx
                                      sub              bx,11                                     ;a partir desse ponto o porgrama vai somando o conteudo do offset das posicoes que estao em volta da posição digitada
                                      add              dl,[bx]

                                      inc              bx
                                      add              dl,[bx]

                                      inc              bx
                                      add              dl,[bx]

                                      add              bx,8
                                      add              dl,[bx]

                                      add              bx, 2
                                      add              dl,[bx]

                                      add              bx,8
                                      add              dl,[bx]

                                      inc              bx
                                      add              dl,[bx]

                                      inc              bx
                                      add              dl,[bx]

                                      cmp              cx,cx_inicial
                                      jz               primeira_vez2

                                      cmp              dl,2
                                      jge              invalido

                                      jmp              fim_verifica_posicao_aleatoria
    primeira_vez2:                    

                                      cmp              dl,1
                                      jb               fim_Verifica_posicao_aleatoria
                                      mov              posicao_Valida,0
   
                                   
                                   
                                      jmp              fim_verifica_posicao_aleatoria
                                   
    invalido:                         
                                 
                                   
                                      mov              posicao_Valida,0
    fim_verifica_posicao_aleatoria:   
                                      pop_all

                                      ret
verifica_Posicao_aleatoria endp

posiciona_Navios_Aleatorio proc

                                      push_all

                                      jmp              inicio_Posicionamento

    inicio_Aleatorio:                                                                            ;Tem que limpar a matriz inteira

                                      mov              cx,89
                                      lea              di,matriz_Adversario
                                      mov              reiniciar,0
                                      mov              contagem_Reposicionamentos,0
                                      mov              contagem_Reposicionamentos_Hidro,0

    limpar_Matriz:                    

                                      mov              byte ptr[di],0
                                      inc              di

                                      loop             limpar_Matriz

                                     
                                      mov              eh_Hidroaviao,0

                                      call             fragata_Aleatorio

                                      mov              eh_Hidroaviao,0

                                    

                                      call             encouracado_Aleatorio

                                      mov              eh_Hidroaviao,0

                                      
                                      call             submarino_Aleatorio

                                      mov              eh_Hidroaviao,0

                                      
                                      call             submarino_Aleatorio

                                      mov              eh_Hidroaviao,0

                                      

                                      mov              eh_Hidroaviao,1

                                      call             hidroaviao_Aleatorio

                                     

                                      mov              eh_Hidroaviao,1

                                      call             hidroaviao_Aleatorio

                                      cmp              reiniciar,1
                                      je               inicio_Aleatorio
                                   

                                      jmp              fim_Posicionamento_al

    inicio_Posicionamento:            
                                   
                                      call             tela_Intermediaria_Fragata

                                      mov              eh_Hidroaviao,0

                                      call             fragata_Aleatorio

                                      mov              eh_Hidroaviao,0

                                      call             tela_Intermediaria_Encourado

                                      call             encouracado_Aleatorio

                                      mov              eh_Hidroaviao,0

                                      call             tela_Intermediaria_Submarino

                                      call             submarino_Aleatorio

                                      mov              eh_Hidroaviao,0

                                      call             tela_Intermediaria_Hidroaviao

                                      call             submarino_Aleatorio

                                      mov              eh_Hidroaviao,0

                                      call             tela_Intermediaria_Submarino

                                      mov              eh_Hidroaviao,1

                                      call             hidroaviao_Aleatorio

                                      call             tela_Intermediaria_Hidroaviao

                                      mov              eh_Hidroaviao,1

                                      call             hidroaviao_Aleatorio

                                      cmp              reiniciar,1
                                      je               corta_Caminho

    fim_Posicionamento_al:                                                                       ;Teoricamente terminou de posicionar tudo, apenas garantir que deu bom

    ;contar todas as posicoes da matriz

                                      mov              cx,89
                                      lea              si,matriz_Adversario
                                      xor              bx,bx

    contagem_Matriz:                  

                                      add              bl,[si]
                                      inc              si

                                      loop             contagem_Matriz

                                      cmp              bl,19
                                      jne              corta_Caminho
                                   
                                      pop_all
                                      ret

    corta_Caminho:                    
                                      jmp              inicio_Aleatorio


posiciona_Navios_Aleatorio endp

hidroaviao_Aleatorio proc

                                      push_all

                                      call             sort_90
                                     
                                      mov              resultado_Sorteio_2,0                     ;Para que ele seja na vertical

                                      mov              eh_Hidroaviao,1                           ;Avisa para as proximas procs que agora sera posicionado um hidroaviao

                                      mov              cx_inicial,3

                                      xor              si,si

                                      lea              si,matriz_Adversario

                                      call             posicona_Posicoes_Aleatorias




                                      pop_all



                                      ret
hidroaviao_Aleatorio endp

encouracado_Aleatorio proc
                                      push_all
                                      call             sort_90

                                      call             sort_2

                                      mov              cx_inicial,4

                                      xor              si,si

                                      lea              si,matriz_Adversario

                                      call             posicona_Posicoes_Aleatorias
                                      pop_all
                                      ret
encouracado_Aleatorio endp

fragata_Aleatorio proc
                                      push_all
                                      call             sort_90

                                      call             sort_2

                                      mov              cx_inicial,3

                                      xor              si,si

                                      lea              si,matriz_Adversario

                                      call             posicona_Posicoes_Aleatorias
                                      pop_all
                                      ret
fragata_Aleatorio endp

submarino_Aleatorio proc

                                      push_all
                                      call             sort_90

                                      call             sort_2

                                      mov              cx_inicial,2

                                      xor              si,si

                                      lea              si,matriz_Adversario

                                      call             posicona_Posicoes_Aleatorias

                                      pop_all
                                      ret
submarino_Aleatorio endp

tela_Posicionamento_Oponente proc

                                      push_all

    ;Explicar -> confirmar cada posicao -> tela tdoas posicoes colocadas e proximos passos

                                      call             limpa_Tela

                                      move_XY          10,5


                                      lea              si,msgposicaooponente1
                                      xor              bx,bx
                                      mov              bl,0ch
                                      call             imprime_Letras

                                      move_XY          14,7

                                      lea              si,msgposicaooponente2
                                      xor              bx,bx
                                      mov              bl,0fh
                                      call             imprime_Letras

                                      move_XY          35,9
                                      lea              si,msgatencao
                                      xor              bx,bx
                                      mov              bl,8ch
                                      call             imprime_Letras

                                      move_XY          18,11

                                      lea              si,msgposicaooponente3
                                      xor              bx,bx
                                      mov              bl,0fh
                                      call             imprime_Letras

                                      move_XY          22,12
                                      lea              si,msgposicaooponente4
                                      xor              bx,bx
                                      mov              bl,0fh
                                      call             imprime_Letras

                                      move_XY          20,14
                                      lea              si,MSGPOSICAOOPONENTE5
                                      add              bx,128
                                      call             imprime_Letras

                                      mov              ah,1
                                      int              21h

                                      pop_all

                                      ret
tela_Posicionamento_Oponente endp

tela_Intermediaria_Encourado proc

                                      push_all

                                      call             limpa_Tela

                                      move_XY          13,7

                                      lea              si,msgalencourado
                                      mov              bl,0ch
                                      call             imprime_Letras

                                      mov              bl,0fh

                                      mov              cx,4
                                      xor              dx,dx
                                      mov              dx,34

    loop_Desenha_Encourado2:          

                                      desenha_Quadrado dl,10

                                      add              dl,3
                                      loop             loop_Desenha_Encourado2

                                      move_XY          19,13

                                      lea              si,msgposicaooponente5
                                      mov              bl,0ch
                                      add              bl,126
                                      call             imprime_Letras
                                   

                                      mov              ah,1
                                      int              21h


                                      call             limpa_Tela

                                      pop_all

                                      ret
tela_Intermediaria_Encourado endp

tela_Intermediaria_Fragata proc

                                      push_all

                                      call             limpa_Tela

                                      move_XY          13,7

                                      lea              si,msgalfragata
                                      mov              bl,0ch
                                      call             imprime_Letras

                                      mov              bl,0fh

                                      mov              cx,3
                                      xor              dx,dx
                                      mov              dx,36

    loop_Desenha_Fragata2:            

                                      desenha_Quadrado dl,10

                                      add              dl,3
                                      loop             loop_Desenha_Fragata2

                                      move_XY          19,13

                                      lea              si,msgposicaooponente5
                                      mov              bl,0ch
                                      add              bl,126
                                      call             imprime_Letras

                                      mov              ah,1
                                      int              21h

                                   

                                      pop_all
                                      ret
tela_Intermediaria_Fragata endp

tela_Intermediaria_Submarino proc

                                      push_all


                                      call             limpa_Tela

                                      move_XY          13,7

                                      lea              si,msgalsubmarino
                                      mov              bl,0ch
                                      call             imprime_Letras

                                      mov              bl,0fh

                                      mov              cx,2
                                      xor              dx,dx
                                      mov              dx,36

    loop_Desenha_Submarino3:          

                                      desenha_Quadrado dl,10
                                      add              dl,3
                                      loop             loop_Desenha_submarino3

                                      move_XY          19,13

                                      lea              si,msgposicaooponente5
                                      mov              bl,0ch
                                      add              bl,126
                                      call             imprime_Letras

                                      mov              ah,1
                                      int              21h

                                      call             limpa_Tela
                                      pop_all

                                      ret
tela_Intermediaria_Submarino endp

tela_Intermediaria_Hidroaviao proc

                                      push_all

                                      call             limpa_Tela

                                      move_XY          13,7

                                      lea              si,msgalhidroaviao
                                      mov              bl,0ch
                                      call             imprime_Letras

                                      mov              bl,0fh

                                      mov              cx,3
                                      xor              dx,dx
                                      mov              dx,36

    loop_Desenha_Hidroaviao3:         

                                      desenha_Quadrado dl,10

                                      add              dl,3
                                      loop             loop_Desenha_Hidroaviao3

                                      desenha_Quadrado 39,12

                                      move_XY          19,14

                                      lea              si,msgposicaooponente5
                                      mov              bl,0ch
                                      add              bl,126
                                      call             imprime_Letras

                                      mov              ah,1
                                      int              21h

                                   

                                      pop_all


                                      ret
tela_Intermediaria_Hidroaviao endp

tela_Inicio_Ataque proc

                                      push_all

                                      MOVE_XY          26,2
                                      lea              si,msginiataque
                                      mov              bl,0ch
                                      call             imprime_Letras

                                      move_XY          18,5
                                      lea              si,msginiataque2
                                      mov              bl,0fh
                                      call             imprime_Letras

                                      move_XY          10,7
                                      lea              si,msginiataque3
                                      call             imprime_Letras

                                      move_XY          16,11
                                      lea              si,msginiataque4
                                      call             imprime_Letras

                                      move_XY          10,13
                                      lea              si,msginiataque5
                                      call             imprime_Letras

                                      move_XY          16,17
                                      lea              si,msginiataque6
                                      call             imprime_Letras

                                      move_XY          36,19
                                      lea              si,msginiataque7
                                      mov              bl,0ch
                                      call             imprime_Letras

                                      move_XY          22,21
                                      lea              si,msgposicaooponente5
                                      add              bl,126
                                      call             imprime_Letras

                                      mov              ah,1
                                      int              21h


                                      pop_all

                                      ret
tela_Inicio_Ataque endp

ataque proc
                                      push_all

                                      call             limpa_Tela

                                      call             imprime_Tabuleiro

                                      move_XY          30,1

                                      lea              si,msgsuavez
                                      mov              bl,0ch
                                      call             imprime_Letras

                                      move_XY          18,2

                                      lea              si,msgataque
                                      call             imprime_Letras

                                      call             pega_Posicao_Ataque                       ;Pega a posicao e ja retorna ela decifrada

                                      call             pega_Posicao_Ataque

                                      pop_all

                                      ret
ataque endp

pega_Posicao_Ataque proc

                                      push_all
                                      xor              dx,dx
                                      xor              di,di
                                      lea              di,posicao_Ataque
                                      mov              byte ptr[di],0
                                      inc              di
                                      mov              byte ptr[di],0
                                      mov              dl,2

    inicio_Pega_Ataque:               

                                      add              dl,3
                                      mov              deu_Errado,0
                                    
                                      move_XY          3,dl
                                      lea              si,msgataque2
                                      mov              bl,0fh
                                      call             imprime_Letras

                                      inc              dl

                                      move_XY          14,dl
                                      mov              cx,2
                                      xor              di,di
                                      lea              di,posicao_Ataque
    loop_Pega_Ataque:                 
                                      mov              ah,1
                                      int              21h                                       ;Esta em AL

                                      mov              byte ptr[di],al
                                      inc              di

                                      loop             loop_Pega_Ataque
    ;;
                                      call             pula_Linha
                                      
                                      call             decifra_Posicao_Ataque

                                      call             verifica_Posicao_Ataque                   ;Se verificar que esta errado, tem que fazer dnv

                                      cmp              deu_Errado,1
                                      je               inicio_Pega_Ataque

                                      pop_all
                                      ret
pega_Posicao_Ataque endp

decifra_Posicao_Ataque proc
                                      push_all

    ;cx com quantas vezes ja rdou
                                      xor              ax,ax
                                      mov              al,10                                     ;Coluna vale como 10 posicoes
                            
                                      lea              di, posicao_Ataque                        ;Passa o endereço da variavel
                                      sub              byte ptr [di], 65                         ;Trasforma a letra para o numero corespondente da linha desejada
                            
                                      mul              byte ptr [di]                             ;Multiplica por 10                            ;Coluna conta como 10 posicoes
                            
                                      inc              di
                                      sub              byte ptr [di],48                          ;Transforma o caracter do numero para apenas o numero

                                      add              al,[di]                                   ; Salva em AX a multipliacap de [si+1] com [si] (salvo em ax anteriormente)
    ; mov              ah,0
                                    
                                      mov              posicao_Ataque_Decifrada,al               ;Funcionando


                                      pop_all
                                      ret
decifra_Posicao_Ataque endp

verifica_Posicao_Ataque proc

                                      push_all

                                      xor              bx,bx
                                      xor              ax,ax
                                      mov              al,posicao_Ataque_Decifrada

                                      lea              bx,matriz_Controle_Adversario
                                      add              bx,ax

                                      cmp              primeira_Tentativa_Ataque,1
                                      je               primeiro_Ataque

                                      cmp              byte ptr[bx],0
                                      je               aprovada_Posicao_Ataque
    ;Posicao que ja foi atacada anteriormente
    ;Avisar que deu erro e pedir para apertar qqr tecla para tentar novamente

    ;Pegar posicao do cursor

                                      mov              ah,3
                                      int              10h                                       ;DH esta com y do curso
                                      add              dh,2


                                      move_XY          5,5
                                      lea              si,msginvalidoataque
                                      mov              bl,0fh
                                      call             imprime_Letras
    ; Pegar denovo a posicao
    ;E ja decifra a nova posicao
                                      mov              deu_Errado,1
                                      jmp              fim_Ataque
                                   
    aprovada_Posicao_Ataque:          

                                      mov              byte ptr[bx],1

    fim_Ataque:                       

                                      pop_all
                                      ret

    primeiro_Ataque:                  
                                      mov              byte ptr[bx],1
                                      mov              primeira_Tentativa_Ataque,0
                                      pop_all
                                      ret

verifica_Posicao_Ataque endp

    fim:                              
                                      mov              ah,4ch
                                      int              21h


main endp
    end main