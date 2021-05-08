org 100h

section .text

    MOV AX, 1d ; valor inicial
    MOV CX, 5d ; colocar 5d en CX (veces a iterar para obtener factorial)
    jmp iterar ; saltar a iterar

iterar:
    MUL CX ; se multiplica CX por ella misma reducida en 1 por iterar
    LOOP iterar ; se itera hasta que CX == 0
fin:
    MOV byte [20Bh], AL ; Copiar Cociente AL a 20Ah checar con -d 20B
    int 20h