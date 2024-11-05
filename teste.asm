.MODEL SMALL
.STACK 100h
.DATA
    resultado  DB ?
    resultado2 DB ?
    msg1       DB "Numero inicial da matriz sorteado: $"
    msg2       DB 10,13,"Segundo numero sorteado: $"
    msg3       DB 10,13,"Posicoes da matriz: $"
.CODE

MAIN PROC
                         MOV  AX, @DATA
                         MOV  DS, AX

    ; Chamar a interrupção 1Ah para obter o contador do timer
                         MOV  AH, 00h
                         INT  1Ah                     ; DX contem o valor do numero aleatorio

                         MOV  CX, 90
                         MOV  AX, DX
                         XOR  DX, DX
                         DIV  CX                      ; DX:AX / CX -> AX = quociente, DX = resto
                         MOV  resultado, DL           ; Armazenar o número sorteado na variável resultado

    ; Mostrar o primeiro número sorteado
                         LEA  DX, msg1
                         MOV  AH, 9
                         INT  21h
                         XOR  AX, AX
                         MOV  AL, resultado
                         CALL imprime_Dois_Digitos

    ; Mostrar o segundo número sorteado
                         LEA  DX, msg2
                         MOV  AH, 9
                         INT  21h

                         MOV  AH, 00h
                         INT  1Ah                     ; DX contem o valor do numero aleatorio

                         MOV  CX, 4
                         MOV  AX, DX
                         XOR  DX, DX
                         DIV  CX
                         MOV  resultado2, DL          ; Armazenar o segundo número sorteado
                         ADD  DL, 30h                 ; Converter o número para ASCII
                         MOV  AH, 2
                         INT  21h

    ; Mostrar as posições da matriz
                         LEA  DX, msg3
                         MOV  AH, 9
                         INT  21h

    ; (Continuação do código para mover nas direções da matriz)
    ; Movimentação da matriz ainda deve ser implementada para as direções corretas.

                         MOV  AH, 4Ch
                         INT  21h
MAIN ENDP

    ; Procedimento para imprimir números de dois dígitos em decimal
imprime_Dois_Digitos PROC
                         MOV  CX, 10

    ; Converter AL em dígitos ASCII de dois dígitos
                         XOR  DX, DX                  ; Limpar DX para garantir que ele está em zero
                         DIV  CL                      ; Dividir AL por 10, AH terá o resto, AL o quociente

    ; Imprimir o primeiro dígito (quociente)
                         ADD  AL, '0'                 ; Converter AL para ASCII
                         MOV  AH, 2
                         INT  21h                     ; Imprimir primeiro dígito

    ; Imprimir o segundo dígito (resto)
                         MOV  AL, AH                  ; Colocar o valor do resto em AL
                         ADD  AL, '0'                 ; Converter para ASCII
                         MOV  AH, 2
                         INT  21h                     ; Imprimir segundo dígito

                         RET
imprime_Dois_Digitos ENDP

END MAIN
