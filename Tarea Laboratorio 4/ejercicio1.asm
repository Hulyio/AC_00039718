; separe los números pares e impares con un arreglo y subrutinas
; MAIN
        org     100h

        section .text

        call    paresimpares    ; llama funcion

        int     20h

        section .data

numeros db      1,2,3,4,5,6,7,8,9,10,0xA        ; arreglo de numeros

; FUNCIONES

; funcion que resuelve el ejercicio
paresimpares:
        xor     SI, SI          ; SI = 0
        xor     AX, AX          ; AX = 0
        xor     BX, BX          ; AX = 0
        xor     DX, DX          ; AX = 0
        mov     BL, 2d
while:
        mov     AL, [numeros+SI]
        mov     DL, [numeros+SI]
        div     BL
        cmp     AH,00   ;or AH,0d
        je      pares
        jne     impares
regresar:        
        cmp     byte      [numeros+SI],0xA
        je      end
        inc SI
        xor     AX, AX          ; AX = 0
        jmp while
end:
        ret        
pares:
        mov     byte    [300h+SI],DL
        jmp regresar
impares:
        mov     byte    [320h+SI],DL
        jmp regresar