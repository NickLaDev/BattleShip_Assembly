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

    quebra_Linha               db 10,13,"$"
    ;------------------------------------------Mensagens-------------------------------------------------------------------------------------------------;
    MSGPEGARNOME               db "Digite o seu nome: $"
    MSGCOMECAPEGAR             db "Comece digitando a posicao do ENCOURADO: $"
    MSGLEMBRESE1               db "Lembre-se o encourado ocupa 4 posicoes, como a seguir: $"
    MSGPEGAPOSICAO             db "Digite a posicao desejada$"
    MSGPEGAPOSICAO2            db "para embarcacao:$"                                                                                                                                                        ;&=padrao estabelecido para quebra de linhas na funcao de imprir criada
    ;--------------------------------------Declaracao das matrizes que serao utilizadas como tabuleiro-------------------------------------------------------------------------------------;
    matriz_Jogador             db 10 dup (9 dup (0))
    matriz_Adversario          db 10 dup (9 dup(0))
    matriz_Controle_Jogador    db 10 dup (9 dup (0))
    matriz_Controle_Adversario db 10 dup (9 dup (0))
    colunas                    db "[1] [2] [3] [4] [5] [6] [7] [8] [9] [10] $"
    linhas                     db "A B C D E F G H I$"
    DIV_1                      DB 218,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,194,196,196,196,191,"$"    ;Usando codigos ASCII para impressao
    DIV_2                      DB 192,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,193,196,196,196,217,"$"    ;das matrizes utilizadas no jogo
    DIV_3                      DB 195,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,197,196,196,196,180,"$"
    DIV_4                      DB 179, 10 dup (3 dup (" "), 179), "$"
    quadrado                   db 219,219,"$"
    ;--------------------------------------Variaveis de ambiente-------------------------------------------------------------------------------------------------------------------;

    nome_Jogador               db 15 dup (?)
    posicao_Desejada           db ?,?

    ;-----------------------------------------------------------------------------------------------------------------------------------------------------------------;
.code

main proc

                            mov              ax,@data
                            mov              ds,ax                      ;Libera acesso ao .DATA

    ;------------------------------------------------------TELA_INCIAL--------------------------------------------------------------------------;

                            call             limpa_Tela

                            move_XY          25,0                       ;Coloca o cursor no centro da tela

                            call             imprimir_Introducao        ;Imprime a introdução e fica travado até apertar alguma tecla

                            call             limpa_Tela                 ;Limpa tela apos sair da proc de cima

                            call             pega_Nome                  ;Pega o nome do jogador

                            call             limpa_Tela                 ;Limpa a tela

                            call             Imprime_tabuleiro          ;Começa a posiconar os navios

                            call             posiciona_Navios
    
    ;---------------------------------FIM_DO_PROGRAMA--------------------------------------------------------------------------------------;
    
                            jmp              fim

    ;--------------------------------Procedimentos:----------------------------------------------------------------------------------------;
    
limpa_Tela proc                                                         ;Procedimento que limpa a tela:

                            push_all

                            MOV              AH,0
                            MOV              AL,3
                            INT              10H

                            pop_all

                            ret


limpa_Tela endp

                
    ;------------------------------------------------------------------------------------------------------------------------------------;
imprime_Letras proc                                                     ;Procedimento para impressao de caracters
    ;Necessário enviar BL e si ( BL = cor e si = endereço do caracter )
    ;O caracter & sera reconhecido como um comando para quebrar linha

                            push_all

                            MOV              BH, 00h                    ; Número da página de vídeo (geralmente 00h)


    impressao_Loop:         

                            cmp              dl,"&"
                            je               pular_Impressao
                            
                            mov              al,[si]
                            MOV              AH, 09h                    ; Função para escrever caractere e atributo
                            MOV              CX, 1                      ; Número de vezes para escrever o caractere
                            INT              10h                        ; Chama a interrupção de vídeo

                            mov              ah,3                       ;dh=linha dl=coluna
                            int              10h
                            inc              dl
                            mov              ah,2                       ;Passa o curso uma posicao para o lado
                            int              10h

                            inc              si
                            mov              dl,[si]
                            cmp              dl,"$"
                            jz               fim_Impressao_Letra        ;Compara para ver se já terminou a
                            jmp              impressao_Loop

    pular_Impressao:        

                            inc              si
                            call             pula_Linha
                            mov              dl,[si]
                            cmp              dl,"$"
                            jz               fim_Impressao_Letra        ;Compara para ver se já terminou a
                            jmp              impressao_Loop
                            



    fim_Impressao_Letra:    
                            
                            call             pula_Linha                 ;Passa para a próxima linha dps da impressao

                            pop_all

                            ret

imprime_Letras endp

imprime_Letras_Vertical proc

    ;Necessário enviar BL e si ( BL = cor e si = endereço do caracter )

                            push_all

                            MOV              BH, 00h                    ; Número da página de vídeo (geralmente 00h)


    impressao_Loop_Vertical:

                            mov              al,[si]
                            MOV              AH, 09h                    ; Função para escrever caractere e atributo
                            MOV              CX, 1                      ; Número de vezes para escrever o caractere
                            INT              10h                        ; Chama a interrupção de vídeo

                            mov              ah,3                       ;dh=linha dl=coluna
                            int              10h
                            inc              dh
                            mov              ah,2                       ;Passa o curso uma posicao para o lado
                            int              10h

                            inc              si
                            mov              dl,[si]
                            cmp              dl,"$"
                            jnz              impressao_Loop_Vertical    ;Compara para ver se já terminou a string

                            call             pula_Linha                 ;Passa para a próxima linha dps da impressao

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

                            MOV              BL, 0ch                    ; Atributo de cor (0ch = texto vermelho)
                            lea              si,msgintro1
                            call             imprime_Letras

                            call             pula_Linha

                            MOV              BL, 0eh                    ; Atributo de cor (0Eh = texto amarelo)
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
                            ADD              BL,128                     ;Faz ficar piscando
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

pega_Posicao proc                                                       ;Procedimento para pegar a posicao que o jogador deseja posicionar suas embarcacoes
    ;Tem que passar cx com a quantidade de vezes que quer rodar
                            push_all
                            xor              dx,dx
                            mov              dx,6                       ;Valores para o posicionamento das mensagens na tela
    loop_Inteiro:           

                            lea              si,msgpegaposicao
                            move_XY          2,dl
                            inc              dx
                            call             imprime_Letras             ;Imprime a primeira parte da mensagem

                            lea              si,msgpegaposicao2
                            move_XY          7,dl
                            call             imprime_Letras             ;Quebra linha e imprime a segunda parte
                            inc              dx

                            
                            push             cx                         ;Guarda o cx antigo
                            mov              cx,2                       ;Atualiza o cx para pegar as duas cordenadas desejadas
                            lea              di,posicao_Desejada        ;Passa a posicao de memoria para di de onde vamos armazenar as cordenadas
                            move_XY          14,dl                      ;Posiciona o cursor
    loop_Pega_Posicao:      

                            mov              ah,1
                            int              21h                        ;Salva em AL o que foi digitado pelo usuario

                            mov              [di],al
                            inc              di                         ;Passa para a variavel a posicao inserida

                            loop             loop_Pega_Posicao          ;Roda duas vezes
                            pop              cx                         ;Volta para o cx antigo
                            inc              dx                         ;Atualiza a posicao do cursor

                            call             decifra_Posicao            ;Decifra qual posicao da matriz tem que ser alterada

                            loop             loop_Inteiro               ;Loop para pegar todas as posicoes necessarias para embarcacao

                            pop_all
                            ret                                         ;Retorna para onde estava
pega_Posicao endp

decifra_Posicao proc
                            push_all
                            xor dx, dx
                            lea si, posicao_Desejada
                            sub byte ptr [si], 38h
                            mov ah, 2
                            mov dl, [si]
                            int 21h
                            add bl, [si]
                            inc si
                            sub byte ptr [si], 30h
                            add bl, [si]
                            mov dx, bx
                            int 21h

                            mov si, bx
                            add matriz_Controle_Jogador[si], 1
                            mov dl, matriz_Controle_Jogador[si]
                            int 21h
                            pop_all


                            ret
decifra_Posicao endp

posiciona_Navios proc
                            push_all

                            move_XY          20,0
                            lea              si,msgcomecapegar
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
    ;
                            mov              cx,4                       ;Passar quantas posicoes precisao ser pegas
                            call             pega_Posicao

                            pop_all

                            ret
posiciona_Navios endp

    fim:                    
                            mov              ah,4ch
                            int              21h


main endp
    end main
