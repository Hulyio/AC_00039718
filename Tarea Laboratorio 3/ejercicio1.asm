org 100h

section .text

    XOR AX, AX ; Limpiar el registro
    XOR BX, BX ; Limpiar el registro
    XOR CX, CX ; Limpiar el registro
    ADD BL, 0d ; Sumar Digitos
    ADD BL, 0d ; Sumar Digitos
    ADD BL, 0d ; Sumar Digitos
    ADD BL, 3d ; Sumar Digitos
    ADD BL, 9d ; Sumar Digitos
    ADD BL, 7d ; Sumar Digitos
    ADD BL, 1d ; Sumar Digitos
    ADD BL, 8d ; Sumar Digitos
    MOV AL, BL ; Copiar Suma a Dividendo
    MOV CL, 8d ; Escribir 8 al Divisor
    DIV CL ; Dividir AX/CL
    MOV byte [20Ah], AL ; Copiar Cociente AL a 20Ah checar con -d 20A
    int 20h ; Fin