title numero aleatorio
.MODEL SMALL
.STACK 100h
.DATA
    msg     db "Numero sorteado: $"
    newline db 13, 10, "$"             ; nova linha em DOS
    result  db 3 dup('$')              ; buffer para o número sorteado (máx 3 dígitos)

.CODE
MAIN PROC
                   MOV  AX, @DATA                  ; Inicializa o segmento de dados
                   MOV  DS, AX

    ; Obtém os segundos do sistema (para simular aleatoriedade)
                   MOV  AH, 2Ch                    ; Função 2Ch - Obter hora do DOS
                   INT  21h                        ; Chama interrupção do DOS
                   MOV  AL, DH                     ; Move os segundos (DH) para AL

    ; Reduz o valor para o intervalo de 0 a 90
                   MOV  CX, 91                     ; Define o limite superior (91) para divisão
                   DIV  CL                         ; AL = AL mod 91, ou seja, AL estará no intervalo 0-90

    ; Converte AL para uma string decimal e armazena em 'result'
                   MOV  BL, AL                     ; Armazena o número aleatório em BL para conversão
                   CALL DecimalToASCII             ; Converte BL para ASCII e armazena em 'result'

    ; Exibe a mensagem "Numero sorteado: "
                   MOV  DX, OFFSET msg
                   MOV  AH, 9
                   INT  21h                        ; Chama interrupção para imprimir a string

    ; Exibe o número sorteado
                   MOV  DX, OFFSET result
                   MOV  AH, 9
                   INT  21h                        ; Chama interrupção para imprimir o número

    ; Imprime uma nova linha
                   MOV  DX, OFFSET newline
                   MOV  AH, 9
                   INT  21h                        ; Chama interrupção para nova linha

    ; Finaliza o programa
                   MOV  AH, 4Ch
                   INT  21h                        ; Termina o programa

MAIN ENDP

    ; Sub-rotina para converter um byte em decimal e armazenar em 'result'
DecimalToASCII PROC
                   MOV  CX, 0                      ; Limpa CX
                   MOV  DI, OFFSET result+2        ; Define DI para armazenar o último dígito

    ConvertLoop:   
                   MOV  AX, BL                     ; Move o número para AX
                   MOV  DX, 0                      ; Limpa DX para divisão
                   MOV  BX, 10                     ; Divisor para obter o dígito decimal
                   DIV  BX                         ; AX / 10 -> AL = quociente, AH = resto
                   ADD  AH, '0'                    ; Converte o resto para ASCII
                   MOV  [DI], AH                   ; Armazena o caractere ASCII no buffer
                   DEC  DI                         ; Move para o próximo dígito (esquerda)
                   INC  CX                         ; Incrementa a contagem de dígitos
                   MOV  BL, AL                     ; Resto da divisão (próximo dígito)
                   OR   BL, BL                     ; Testa se BL é zero
                   JNZ  ConvertLoop                ; Continua até não haver mais dígitos

    ; Ajusta os dígitos para a posição correta no buffer
                   MOV  DI, OFFSET result
                   ADD  DI, 3
                   SUB  DI, CX                     ; Aponta DI para o primeiro dígito não-nulo
                   MOV  SI, DI

    ; Ajusta o resultado para a posição inicial do buffer
                   MOV  DI, OFFSET result
                   REP  MOVSB                      ; Copia o número para a posição inicial
                   MOV  BYTE PTR [DI + CX], '$'    ; Adiciona o caractere de terminação '$'

                   RET
DecimalToASCII ENDP
END MAIN
