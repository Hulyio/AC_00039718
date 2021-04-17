    ;Tarea 2 ADC Julio Alfredo Machado Olivo 00039718
    org 100h

    section .text

    ;Escribir cuatro iniciales de su nombre completo 
    ;empezando en la dirección de memoria 200h

    mov byte[200h], "J"
    mov	byte[201h], "A"
    mov	byte[202h], "M"
    mov	byte[203h], "O"

    ;Luego, mover a los siguientes registros los códigos ASCII 
    ;de los caracteres guardados en 200h
    
    ;Copiar el valor de 200h a AX 
    ;usando direccionamiento directo.
    mov 	AX, [200h]

    ;Copiar el valor de 201h a CX
    ;usando direccionamiento indirecto por registro.
    mov	    BX, 201h
    mov	    CX, [BX]

    ;Copiar el valor de 202h a DX 
    ;usando direccionamiento indirecto base más índice.
    mov     SI, 1h
    mov 	DX, [BX+SI]

    ;Copiar el valor de 203h a DI 
    ;usando direccionamiento relativo por registro.
    mov SI, 200h
    mov DI, [SI+3h]

    ;fin del programa
    int	20h