;Julio Alfredo Machado Olivo 00039718
;Leer una cadena y compararla con una contraseña
	org 	100h

	section	.text

	; leer frase
	mov 	BP, frase
	call  	LeerCadena

    ; print comparar con clave
	call 	comparar

    ;imprimir correcto o incorrecto
    call 	EscribirCadena

    ;esperar que usuario pulse tecla y termine el programa
	call	EsperarTecla

	int 	20h

	section	.data

frase 	times 	6  	db	" "; variable para frase
clave db "qwert",0;clave personalizable
largo equ  $ - clave;largo de clave
msgok 	db 	"BIENVENIDO", "$"
msgbad 	db 	"INCORRECTO", "$"

; FUNCIONES

; Permite leer un carácter de la entrada estándar con echo
; Parámetros:   AH: 07h         
; Salida:       AL: caracter ASCII leído
EsperarTecla:
        mov     AH, 01h         
        int     21h
        ret


; Leer cadena de texto desde el teclado
; Salida:       SI: longitud de la cadena 		BP: direccion de guardado
LeerCadena:
        xor     SI, SI          ; SI = 0
while:  
        call    EsperarTecla    ; retorna un caracter en AL
        cmp     AL, 0x0D        ; comparar AL con caracter EnterKey
        je      exit            ; si AL == EnterKey, saltar a exit
        mov     [BP+SI], AL   	; guardar caracter en memoria
        inc     SI              ; SI++
        jmp     while           ; saltar a while
exit:
	mov 	byte [BP+SI], "$"	; agregar $ al final de la cadena
        ret


; Permite escribir en la salida estándar una cadena de caracteres o string, este
; debe tener como terminación el carácter “$”
; Parámetros:	AH: 09h 	DX: dirección de la celda de memoria inicial de la cadena
EscribirCadena:
	mov 	AH, 09h
	int 	21h
	ret

comparar:   ;con esta llamada comparo mi clave personaliza con el input
    xor     si, si
    xor     di, di
    xor     dx, dx
    xor     ax, ax
    xor     bx, bx
    xor     cx, cx ; limpio todas las variables
    mov     si, clave
    mov     di, frase   ;utilizo si y di para apuntar al inicio de las variables
bucle:
    mov     al, byte [si + bx]
    mov     dl, byte [di + bx]  ; guardo en al y dl la letra de la variable en la iteracion
    cmp     dl,al   ;comparo las dos letras
    je      sumarigual
    jne     nosumarigual ;solo sumo a cx cuando las letras son iguales
sumarigual:
    inc cx
nosumarigual:
    inc     bx ;incremento el registro del bucle
    cmp     bx, largo ;comparo si ya he terminado mi bucle
    je      finbucle
    jne     bucle ;salgo solo si termino mi bucle
finbucle:
    cmp cx,5d ;comparo si todos los caracteres eran iguales
    jne     malo
    je      bueno
malo:
    mov 	DX, msgbad
    jmp     salir
bueno:
    mov 	DX, msgok
    jmp     salir
salir:
    ret