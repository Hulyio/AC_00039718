;Julio Alfredo Machado Olivo 00039718
org 100h

    section .text
    xor AX, AX
    xor SI, SI
    xor BX, BX
    XOR CX, CX
    xor DX, DX

    MOV SI, 0
    MOV DI, 0d

    MOV DH, 10 ;fila en la que se mostrará el cursor
    MOV DL, 20 ;columna en la que se mostrará el cursor

    call modotexto ; configura la pantalla en modo texto

    iterar: 
        ;Loop para mover el cursor y el caracter a imprimir en pantalla
        call movercursor ;llamada a mover cursor
        MOV CL, [cadena+SI] ;Colocar en CL el caracter actual de la cadena
        call escribircaracter; Llamada a escribircaracter
        CMP DI, 5d ; salta dos filas al terminar mi primer nombre
        JE moverfilas ; llamada a mover filas
        CMP DI, 13d ; salta dos filas al terminar mi segundo nombre
        JE moverfilas ; llamada a mover filas
        CMP DI, 21d ; salta dos filas al terminar mi primer apellido
        JE moverfilas ; llamada a mover filas
    regresariterar:
        INC SI ; SE SUMA 1 A SI PARA CONTINUAR CON EL SIGUIENTE CARACTER
        INC DL ; SE SUMA 1 A DL PARA MOVER CURSOR A LA SIGUIENTE COLUMNA
        INC DI ; contador para terminar la ejecución del programa al llegar a 27
        CMP DI, 27d ; Comparación de DI con 27d que es el final de la cadena
        JB iterar ; si DI es menor a 27, entonces que siga iterando.
        jmp esperartecla ; de caso contrario, que salte a esperar tecla.

    modotexto: 
        ;Similar a usar una función en alto nivel
        ;Modotexto(parametro1)
        ;Donde: parametro1= AL (modo gráfico deseado)
        MOV AH, 0h ; activa modo texto
        MOV AL, 03h ; modo gráfico deseado
        INT 10h
        RET
    moverfilas:
        ;desplaza dos filas en pantalla y reinicia el contador de columnas
        INC DH
        INC DH
        MOV DL, 19 ; empieza en 19 porque al regresar incrementara de nuevo
        jmp regresariterar

    movercursor:
        ;Similar a usar una función en alto nivel
        ;MoverCursor(parametro1, parametro2, parametro3,...)
        ;Donde: Parametro1 = DH (fila del cursor), parametro2 = DL (columna del cursor), parametro 3 = BH (número de página)
        MOV AH, 02h ; posiciona el cursor en pantalla.
        MOV BH, 0h 
        INT 10h
        RET
    escribircaracter:
        ;Similar a usar una función en alto nivel
        ;EscribirCaracter(parametro1, parametro2, parametro3,...)
        ;Donde: parametro1 = AL (caracter), parametro2 = BH (número de página), parametro3 = BL (estilo del texto en 8 bits)...
        MOV AH, 0Ah ; escribe caracter en pantalla según posición del cursor
        MOV AL, CL ; denotamos el caracter a escribir en pantalla, los valores deben ser según código hexadecimal de tabla ASCII
        MOV BH, 0h ; número de página
        MOV CX, 1h ; número de veces a escribir el caracter
        INT 10h
        RET

    esperartecla:
    ;Se espera que el usuario presione una tecla
        MOV AH, 00h ;espera buffer del teclado para avanzar en la siguiente instrucción
        INT 16h
    exit:
        int 20h

    section .data

    cadena DT 'Julio Alfredo Machado Olivo'