org 100h

section .text

    XOR CX, CX
    XOR AX, AX
    MOV word CX, 8d
    CALL sumar
    CALL promedio
    CALL fin

sumar:
    ADD AL, [carnet+DI]
    INC DI
    LOOP sumar

promedio:
    MOV BX, 8d
    DIV BX
    MOV [20Ah], AL

fin:
    int 20h

section .data
    carnet DB 0,0,0,3,9,7,1,8