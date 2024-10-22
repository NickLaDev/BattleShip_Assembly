.model small
.data
.stack 100h
.code
main proc

         mov dx,9
         mov ah,2
         int 21h
         mov ah, 4ch
         int 21h

main endp
end main