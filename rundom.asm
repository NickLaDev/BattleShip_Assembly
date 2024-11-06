title numero aleatorio 0-89
.model small
.stack 100h
.data
     resultado  db ?
     resultado2 db ?
     msg1       db "Numero Inicial da matriz sorteado: $"
     msg2       db 10,13,"Segundo numero sorteado: $"
     msg3       db 10,13,"Posicoes da matriz: $"
.code

main proc

                                  mov  ax,@data
                                  mov  ds,ax

                                  call sort_90

                                  lea  dx,msg1
                                  mov  ah,9
                                  int  21h

                                  xor  ax,ax
                                  mov  al,resultado

                                  call imprime_Dois_Digitos

                                  lea  dx,msg2
                                  mov  ah,9
                                  int  21h

                                  call sort_4

                                  add  dl,30h
                                  mov  ah,2
                                  int  21h

                                  lea  dx,msg3
                                  mov  ah,9
                                  int  21h

                                  call posicona_Posicoes_Aleatorias

                                  mov  ah,4ch
                                  int  21h

main endp

imprime_Dois_Digitos proc                                               ; Tem que passar para AL o numero que deseja ser impresso

                        
                                  push ax
                                  push bx
                                  push cx
                                  push dx


                                  mov  cx,10

     ;Imprimir numero de dois digitos em decimal

                                  xor  bx,bx

     print_Loop:                  

                                  div  cl                               ;Divide Ax pelo valor posto; Salva em al resultado e ah = rest

                                  mov  bl,ah
                                  push bx

                                  mov  ah,0

                                  cmp  al,0
                                  je   fim_Impressao
                                  jmp  print_Loop


     fim_Impressao:               

                                  mov  cx,2

     loop_fim_Impressao:          

                                  xor  dx,dx
                                  pop  dx

     ;cmp  dx,0
     ;jb   fim

     ;cmp  dx,9
     ;ja   fim

                                  add  dl,30h
                                  mov  ah,2
                                  int  21h

     ;jmp  fim_Impressao
                                  loop loop_fim_Impressao

     fim:                         

                                  pop  dx
                                  pop  cx
                                  pop  bx
                                  pop  ax

                                  ret

imprime_Dois_Digitos endp

sort_90 proc


     ; Chamar a interrupção 1Ah para obter o contador do timer
                                  MOV  AH, 00h
                                  INT  1Ah                              ; Dx contem o valor do numero aleatorio

                                  mov  cx,90
                                  mov  ax,dx
     ; vamos dividir por 90 para obter um valor de 0 a 89
                                  xor  dx,dx
                                  div  cx                               ; DX:AX / CX -> AX = quociente, DX = resto


     ; o resto (DX) será nosso número aleatório de 0 a 89

     ; Armazenar o número sorteado na variável resultado
   
                                  MOV  resultado, dl

                                  ret
sort_90 endp

sort_4 proc


                                  xor  dx,dx

                                  MOV  AH, 00h
                                  INT  1Ah                              ; Dx contem o valor do numero aleatorio

                                  xor  ax,ax

                                  mov  cx,4
                                  mov  ax,dx
                                  xor  dx,dx
                                  div  cx
               
                                  MOV  resultado2, dl

                                  ret
sort_4 endp


posicona_Posicoes_Aleatorias proc                                       ;Passar cx com a quantidade de posicoes

                                  xor  dx,dx
                                  xor  bx,bx

                                  mov  bl,resultado
                                  mov  dl,resultado2
                                  mov  cx,4

                                  cmp  dx,0                             ;Cima
                                  je   para_Cima

                                  cmp  dx,1                             ;Baixo
                                  je   para_Baixo

                                  cmp  dx,2                             ;Direita
                                  je   para_Direita

                                  cmp  dx,3                             ;Esquerda
                                  je   para_Esquerda

     para_Cima:                   
                          
                                  xor  ax,ax
                                  mov  al,bl

                                  call imprime_Dois_Digitos

                                  sub  bl,10
 
                                  loop para_Cima

                                  jmp  fim_Total

     para_Baixo:                  


                                  xor  ax,ax
                                  mov  al,bl
                                  call imprime_Dois_Digitos


                                  add  bl,10
 
                                  loop para_Baixo



                                  jmp  fim_Total
     para_Esquerda:               



                                  xor  ax,ax
                                  mov  al,bl
                                  call imprime_Dois_Digitos


                                  add  bl,1
 
                                  loop para_Esquerda



                                  jmp  fim_Total
     para_Direita:                


                                  xor  ax,ax
                                  mov  al,bl
                                  call imprime_Dois_Digitos


                                  sub  bl,1
 
                                  loop para_Direita


     fim_Total:                   

                                  ret
posicona_Posicoes_Aleatorias endp


end main