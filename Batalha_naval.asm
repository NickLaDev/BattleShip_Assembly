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
    MSGINTRO1                  db "Bem vindo ao jogo de batalha naval! $"
    MSGINTRO2                  db "Regras para jogar: $"
    MSGINTRO3                  db "Terao de ser inseridos 1 encouracado, 1 fragata, 2 submarinos e 2 hidroavioes $"
    MSGINTRO4                  db "Encourada -> Ocupa 4 posicoes em linha reta $"
    MSGINTRO5                  db "Fragata -> 3 posicoes em linha reta $"
    MSGINTRO6                  db "Submarino -> 2 posicoes em linha reta $"
    MSGINTRO7                  db "Hidroaviao -> 3 posicoes em linha reta e uma na horizonta no meio dessas $"
    MSGINTRO8                  db "O jogador deve posicionar cada embarcacao com uma distancia minima de uma casa $"
    MSGINTRO9                  db "Ganha quem acertar o todos os navios do openente $"
    MSGINTRO10                 db "Pressione qualquer tecla para continuar! $"
    MSGINVALIDO                db "A posicao digitada eh invalida. $"

    quebra_Linha               db 10,13,"$"
    ;------------------------------------------Mensagens-------------------------------------------------------------------------------------------------;
    MSGPEGARNOME               db "Digite o seu nome: $"
    MSGENCOURADO               db "Comece digitando a posicao do ENCOURADO: $"
    MSGFRAGATA                 db "Digite a posicao do FRAGATA: $"
    MSGSUBMARINO               db "Digite a posicao do SUBMARINO: $"
    MSGLEMBRESE1               db "Lembre-se o encourado ocupa 4 posicoes, como a seguir: $"
    MSGLEMBRESE_FRAGATA        db "Lembre-se, o fragata ocupa 3 posicoes como a seguir: $"
    MSGLEMBRESE_SUBMARINO      db "Lembre-se, o Subamarino ocupa 2 posicoes, como a seguir: $"
    MSGPEGAPOSICAO             db "Digite a posicao desejada$"
    MSGPEGAPOSICAO2            db "para embarcacao:$"
    MSGPOSICAOOPONENTE1        db "Agora, o Computador ira alocar a posicao de suas embarcacoes $"
    MSGPOSICAOOPONENTE2        db "Serao posicionadas as mesmas embarcacoes anteriores $"
    MSGPOSICAOOPONENTE3        DB "Pressione qualquer tecla, a cada embarcacao $"
    MSGPOSICAOOPONENTE4        DB "para liberar o pc para posiciona-la $"
    MSGPOSICAOOPONENTE5        DB "PRESSIONE QUALQUER TECLA PARA CONTINUCAR $"
    MSGATENCAO                 DB "ATENCAO:$"
    MSGALENCOURADO             DB "Agora, libere o computador para posicionar o ENCOURADO $"
    MSGALFRAGATA               DB "Agora, libere o computador para posicionar a FRAGATA $"
    MSGALSUBMARINO             DB "Agora, libere o computador para posicionar o SUBMARINO $"
    MSGALHIDROAVIAO            DB "Agora, libere o computador para posicionar o HIDROAVIAO $"
    
    ;&=padrao estabelecido para quebra de linhas na funcao de imprir criada
    ;--------------------------------------Declaracao das matrizes que serao utilizadas como tabuleiro-------------------------------------------------------------------------------------;
    matriz_Jogador             db 10 dup (9 dup (0))
    matriz_Adversario          db 10 dup (9 dup(0)),"$"
    matriz_Controle_Jogador    db 10 dup (9 dup (0)),"$"
    matriz_Controle_Adversario db 10 dup (9 dup (0))
    colunas                    db "[0] [1] [2] [3] [4] [5] [6] [7] [8] [9] $"
    linhas                     db "A B C D E F G H I$"
    DIV_1                      DB 218,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,191,"$"    ;Usando codigos ASCII para impressao
    DIV_2                      DB 192,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,217,"$"    ;das matrizes utilizadas no jogo
    DIV_3                      DB 195,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,180,"$"
    DIV_4                      DB 179, 10 dup (3 dup (" "), 179), "$"
    quadrado                   db 219,219,"$"
    ;--------------------------------------Variaveis de ambiente-------------------------------------------------------------------------------------------------------------------;

    nome_Jogador               db 15 dup (?)
    posicao_Desejada           db ?,?
    posicao_Desejada_Decifrada db ?,"$"
    posicao_anterior           dw 0
    cx_inicial                 dw ?
    resultado_Sorteio_1        db ?
    resultado_Sorteio_2        db ?
    ;-----------------------------------------------------------------------------------------------------------------------------------------------------------------;
.code

main proc

                                 mov              ax,@data
                                 mov              ds,ax                           ;Libera acesso ao .DATA

    ;------------------------------------------------------TELA_INCIAL--------------------------------------------------------------------------;

                                 call             limpa_Tela

                                 move_XY          25,0                            ;Coloca o cursor no centro da tela

    ; call             imprimir_Introducao             ;Imprime a introdução e fica travado até apertar alguma tecla

                                 call             limpa_Tela                      ;Limpa tela apos sair da proc de cima

    ;  call             pega_Nome                       ;Pega o nome do jogador

                                 call             limpa_Tela                      ;Limpa a tela

    ;call             Imprime_tabuleiro               ;Começa a posiconar os navios

    ;  call             posiciona_Navios

    ; call             tela_Posicionamento_Oponente

                                 call             limpa_Tela

    ;call             imprime_Tabuleiro

                                 call             posiciona_Navios_Aleatorio

                                 xor              si,si

                                 lea              si,matriz_Adversario

                                 call             imprime_Tabuleiro

                                 call             posiciona_Posicao
    
    ;---------------------------------FIM_DO_PROGRAMA--------------------------------------------------------------------------------------;
    
                                 jmp              fim

    ;--------------------------------Procedimentos:----------------------------------------------------------------------------------------;
    
limpa_Tela proc                                                                   ;Procedimento que limpa a tela:

                                 push_all

                                 MOV              AH,0
                                 MOV              AL,3
                                 INT              10H

                                 pop_all

                                 ret


limpa_Tela endp

                
    ;------------------------------------------------------------------------------------------------------------------------------------;
imprime_Letras proc                                                               ;Procedimento para impressao de caracters
    ;Necessário enviar BL e si ( BL = cor e si = endereço do caracter )
    ;O caracter & sera reconhecido como um comando para quebrar linha

                                 push_all

                                 MOV              BH, 00h                         ; Número da página de vídeo (geralmente 00h)


    impressao_Loop:              

                                 cmp              dl,"&"
                                 je               pular_Impressao
                            
                                 mov              al,[si]
                                 MOV              AH, 09h                         ; Função para escrever caractere e atributo
                                 MOV              CX, 1                           ; Número de vezes para escrever o caractere
                                 INT              10h                             ; Chama a interrupção de vídeo

                                 mov              ah,3                            ;dh=linha dl=coluna
                                 int              10h
                                 inc              dl
                                 mov              ah,2                            ;Passa o curso uma posicao para o lado
                                 int              10h

                                 inc              si
                                 mov              dl,[si]
                                 cmp              dl,"$"
                                 jz               fim_Impressao_Letra             ;Compara para ver se já terminou a
                                 jmp              impressao_Loop

    pular_Impressao:             

                                 inc              si
                                 call             pula_Linha
                                 mov              dl,[si]
                                 cmp              dl,"$"
                                 jz               fim_Impressao_Letra             ;Compara para ver se já terminou a
                                 jmp              impressao_Loop
                            



    fim_Impressao_Letra:         
                            
                                 call             pula_Linha                      ;Passa para a próxima linha dps da impressao

                                 pop_all

                                 ret

imprime_Letras endp

imprime_Letras_Vertical proc

    ;Necessário enviar BL e si ( BL = cor e si = endereço do caracter )

                                 push_all

                                 MOV              BH, 00h                         ; Número da página de vídeo (geralmente 00h)


    impressao_Loop_Vertical:     

                                 mov              al,[si]
                                 MOV              AH, 09h                         ; Função para escrever caractere e atributo
                                 MOV              CX, 1                           ; Número de vezes para escrever o caractere
                                 INT              10h                             ; Chama a interrupção de vídeo

                                 mov              ah,3                            ;dh=linha dl=coluna
                                 int              10h
                                 inc              dh
                                 mov              ah,2                            ;Passa o curso uma posicao para o lado
                                 int              10h

                                 inc              si
                                 mov              dl,[si]
                                 cmp              dl,"$"
                                 jnz              impressao_Loop_Vertical         ;Compara para ver se já terminou a string

                                 call             pula_Linha                      ;Passa para a próxima linha dps da impressao

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

                                 MOV              BL, 0ch                         ; Atributo de cor (0ch = texto vermelho)
                                 lea              si,msgintro1
                                 call             imprime_Letras

                                 call             pula_Linha

                                 MOV              BL, 0eh                         ; Atributo de cor (0Eh = texto amarelo)
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
                                 ADD              BL,128                          ;Faz ficar piscando
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

pega_Posicao proc                                                                 ;Procedimento para pegar a posicao que o jogador deseja posicionar suas embarcacoes
    ;Tem que passar cx com a quantidade de vezes que quer rodar
                                 push_all
                                 xor              dx,dx
                                 mov              dx,6                            ;Valores para o posicionamento das mensagens na tela
                                 mov              cx_inicial,cx
    loop_Inteiro:                

                                 lea              si,msgpegaposicao
                                 move_XY          2,dl
                                 inc              dx
                                 call             imprime_Letras                  ;Imprime a primeira parte da mensagem

                                 lea              si,msgpegaposicao2
                                 move_XY          7,dl
                                 call             imprime_Letras                  ;Quebra linha e imprime a segunda parte
                                 inc              dx

    ;IMRPIMIU AS MSGS

                                 push             cx                              ;Guarda o cx antigo
                                 mov              cx,2                            ;Atualiza o cx para pegar as duas cordenadas desejadas
                                 lea              di,posicao_Desejada             ;Passa a posicao de memoria para di de onde vamos armazenar as cordenadas
                                 move_XY          14,dl                           ;Posiciona o cursor
    loop_Pega_Posicao:           

                                 mov              ah,1
                                 int              21h                             ;Salva em AL o que foi digitado pelo usuario

                                 mov              [di],al
                                 inc              di                              ;Passa para a variavel a posicao inserida

                                 loop             loop_Pega_Posicao               ;Roda duas vezes


    ;Posicao desejada contem a posicao que o jogador inseriu, verificar se a posicao é possivel




                                 pop              cx                              ;Volta para o cx antigo
                                 inc              dx                              ;Atualiza a posicao do cursor


                                 call             decifra_Posicao                 ;Decifra qual posicao da matriz tem que ser alterada

                                 loop             loop_Inteiro                    ;Loop para pegar todas as posicoes necessarias para embarcacao

                                 pop_all
                                 ret                                              ;Retorna para onde estava
pega_Posicao endp

verifica_Posicao proc
                                 push_all
                                 xor              dx, dx
                                 mov              bx,di                           ;move o offset da posição digitada para bx
                                 sub              bx,11                           ;a partir desse ponto o porgrama vai somando o conteudo do offset das posicoes que estao em volta da posição digitada
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
                                 jz               primeira_vez                    ;verifica se a label esta sendo rodada pela primeira vez

                                 cmp              dx,1
                                 jnz              posicao_Aprovada                ;verifica se há duas posicoes setadas em volta da posicao digitada, pois a partir da segunda posicao do barco sempre terá pelo menos uma posicao setada e volta da digitada
                                 jmp              liberado

    primeira_vez:                
                                 cmp              dx,0                            ;garante que a primeira posição do barco tenha distacia de pelo menos 1 casa de qualquer embarcação
                                 jnz              posicao_Aprovada

    liberado:                    
    ;DI vai chegar com os valor da posicao absoluta atual digitada
    ;posicao_Anterior guarda a posicao absoluta anterior (tudo em offset)


                                 cmp              cx,cx_inicial
                                 je               posicao_Aprovada                ;Primeira vez que está rodando, então nao precisa verficar

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

verifica_Posicao endp


decifra_Posicao proc
                                 push_all
    ;cx com quantas vezes ja rdou
                                 xor              ax,ax
                                 mov              al,10                           ;Coluna vale como 10 posicoes
                            
                                 lea              si, posicao_Desejada            ;Passa o endereço da variavel
                                 sub              byte ptr [si], 65               ;Trasforma a letra para o numero corespondente da linha desejada
                            
                                 mul              byte ptr [si]                   ;Coluna conta como 10 posicoes
                            
                                 inc              si
                                 sub              byte ptr [si],48                ;Transforma o caracter do numero para apenas o numero

                                 add              ax,[si]                         ; Salva em AX a multipliacap de [si+1] com [si] (salvo em ax anteriormente)

    ;Ax está com a posição absoluta desejada

                                 lea              di,matriz_Controle_Jogador
                                 add              di,ax                           ;Passa para a matriz o valor 1 na posicao desejada

                                 call             verifica_Posicao                ;Passa para DI com a posicaod da memoria que desejamso alterar ( offset matriz + Posicao desejada )
                                 jnz              errado

                                 mov              byte ptr [di],1
                            
                                 mov              posicao_anterior, di

                                 lea              si,matriz_Controle_Jogador      ;Passa como parametro para o procedimento a matriz que tem q ser impressa
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

posiciona_Posicao proc                                                            ;Tem que receber em si o endereço da matriz

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
                                 jne              roda_Matriz                     ;-> virar call
                            
                                 call             imprime_Posicao

                                 jmp              roda_Matriz


    fim_1:                       
                                 pop_all
                                 ret

posiciona_Posicao endp

imprime_Posicao proc


                                 push_all

                            
                                 xor              ax,ax
                                 xor              dx,dx                           ;Limpa registradores

                                 dec              cx
                                 mov              al,cl

                                 mov              cl,10
                                 div              cl                              ;Divide Al por Cl e salva resultado em AL e resto em AH
                                 xor              bx,bx
                                 mov              bl,ah                           ;salva em BL o resto

                                 xor              dx,dx
                                 mov              cl,2
                                 mul              cl
                                 push             ax                              ;Multiplica o resultado por 2 dando a quantidade de linhas para baixo

                                 xor              ax,ax
                                 mov              al,bl
                                 mov              cl,4
                                 mul              cl
                                 xor              bx,bx                           ;Multiplica o resto por 4 para dar a quantidade de colunas para o lado
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
    
                                 mov              cx,4                            ;Passar quantas posicoes precisao ser pegas
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
                                 lea              si,matriz_Controle_Jogador      ;Passa como parametro para o procedimento a matriz que tem q ser impressa
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
                                 lea              si,matriz_Controle_Jogador      ;Passa como parametro para o procedimento a matriz que tem q ser impressa
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
                                 lea              si,matriz_Controle_Jogador      ;Passa como parametro para o procedimento a matriz que tem q ser impressa
                                 call             posiciona_Posicao

                            

                                 mov              cx,2
                                 call             pega_Posicao




    ; fazer verificar se a posicao pe valida

                                 pop_all

                                 ret
posiciona_Navios endp

sort_90 proc                                                                      ;Sorteia um nuemro de 0 a 89 e retorna na variavel Resultado o valor do sorteio

                                 push_all

    ; Chamar a interrupção 1Ah para obter o contador do timer
                                 MOV              AH, 00h
                                 INT              1Ah                             ; Dx contem o valor do numero aleatorio

                                 mov              cx,90
                                 mov              ax,dx
    ; vamos dividir por 90 para obter um valor de 0 a 89
                                 xor              dx,dx
                                 div              cx                              ; DX:AX / CX -> AX = quociente, DX = resto


    ; o resto (DX) será nosso número aleatório de 0 a 89

    ; Armazenar o número sorteado na variável resultado
   
                                 mov              resultado_Sorteio_1, dl

                                 pop_all

                                 ret
sort_90 endp

sort_2 proc                                                                       ;Sorteia um nuemro de 0-3 e retorna na variavel resultado2 o valor do sorteio

                                 push_all

                                 xor              dx,dx

                                 MOV              AH, 00h
                                 INT              1Ah                             ; Dx contem o valor do numero aleatorio

                                 xor              ax,ax

                                 mov              cx,2
                                 mov              ax,dx
                                 xor              dx,dx
                                 div              cx
               
                                 MOV              resultado_Sorteio_2, dl

                                 pop_all

                                 ret
sort_2 endp

posicona_Posicoes_Aleatorias proc                                                 ;Passar cx com a quantidade de posicoes

    ; Receber posicao da memoria da matriz do computador para poder mecher nela ( em SI )
                                 push_all

                                 xor              dx,dx
                                 xor              bx,bx
                                 xor              si,si

                                 mov              bl,resultado_Sorteio_1
                                 mov              dl,resultado_Sorteio_2
                                 lea              si,matriz_Adversario
                                 add              si,bx                           ; ( Offset matriz + posicao aleatoria )
    ;Si é oque tem q ser passado para o verefica posicao, so que por DI


                                 mov              cx,cx_inicial

                                 lea              ax,matriz_Adversario

                                 add              ax,30

                                 cmp              dx,0                            ;Cima
                                 je               Vertical

                                 cmp              dx,1                            ;Direita
                                 je               Horizontal
    Vertical:                    

                                 cmp              si,ax

                                 jge              verifica_posicao_concluida
                                 
                                 add              si, 10
                                 
                                 jmp              Vertical
                                 
    verifica_posicao_concluida:  

                                 mov              di,si
                                 
                                 call             verifica_Posicao                ;Vai vereficar se a posição pode ser inserida ou nao ( Se há barcos em voltas )

    ;Tem que ser passado para di o offset da matriz + da posicao aleatoria

                                 jnz              ta_errado
                                 
                                 mov              byte ptr [si],1

                                 sub              si,10

                                 loop             verifica_posicao_concluida
                                 
                                 jmp              fim_Total

    ta_errado:                   
                                 call             sort_90
                                 
                                 call             sort_2

                                 cmp              cx,cx_inicial
                                 
                                 jnz              apaga_posicioes

                                 jmp              posicona_Posicoes_Aleatorias

    apaga_posicioes:             

                                 add              di,10

                                 mov              byte ptr [di],0

                                 inc              cx

                                 jmp              ta_errado
    Horizontal:                  
                                 xor              bx,bx
                                 xor              ax,ax
                                 mov              al,resultado_Sorteio_1
                                 mov              bl,10
                                 div              bl                              ;Resto, que esta em ah, tem que ser menor ou igual 6
                                 div              bl
                                 sub              bx,cx_inicial
                                 cmp              ah,bl
                                 jbe              verifica_posicao_concluida2

                                 mov              al,ah
                                 mov              ah,0
                                 sub              al,bl
                                 sub              si,ax
                                 mov              cx,cx_inicial
    verifica_posicao_concluida2: 

    ;jmp              Horizontal

                                 mov              byte ptr [si],1

                                 add              si,1
 
                                 loop             verifica_posicao_Concluida2


    fim_Total:                   

                                 pop_all

                                 ret
posicona_Posicoes_Aleatorias endp

posiciona_Navios_Aleatorio proc

                                     
                                 call             fragata_Aleatorio

                                 call             tela_Intermediaria_Encourado

                                 call             encouracado_Aleatorio

                                 ret
posiciona_Navios_Aleatorio endp

encouracado_Aleatorio proc

                                 call             sort_90

                                 call             sort_2

                                 mov              cx_inicial,4

                                 xor              si,si

                                 lea              si,matriz_Adversario

                                 call             posicona_Posicoes_Aleatorias


                                 ret
encouracado_Aleatorio endp

fragata_Aleatorio proc

                                 call             sort_90

                                 call             sort_2

                                 mov              cx_inicial,3

                                 xor              si,si

                                 lea              si,matriz_Adversario

                                 call             posicona_Posicoes_Aleatorias

                                 ret
fragata_Aleatorio endp

submarino_Aleatorio proc


                                 call             sort_90

                                 call             sort_2

                                 mov              cx_inicial,2

                                 xor              si,si

                                 lea              si,matriz_Adversario

                                 call             posicona_Posicoes_Aleatorias


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

    fim:                         
                                 mov              ah,4ch
                                 int              21h


main endp
    end main
