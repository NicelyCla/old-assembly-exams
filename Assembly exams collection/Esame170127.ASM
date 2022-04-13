SECTION data

	Sorg1: db "Pera",0
	Sorg2: db "Ascia",0
	Dest: resb 100


SECTION text
..start:
	mov ax, data
	mov ds, ax
	mov es, ax
	
	xor dx,dx

    mov si, Sorg2
    mov bx, Sorg1
	mov di, Dest ; dest


Leggi:
	mov ah,00h
	int 16h

	cmp al,1bh
	je FineLettura
	
	mov ah,0eh
	;mov bx,00h
	int 10h

	;metto il carattere letto
	xor ah,ah
	sub al,30h ; trasformo l'ascii in numero
	push ax

	mov ax,Sorg1
	push ax
	mov ax,Sorg2
	push ax
	mov ax, Dest
	push ax
	
	call CopiaAlternata
	add sp,8

	jmp Leggi


CopiaAlternata:
	push bp
	mov bp, sp

	;mov di, [bp+4] ; dest

	mov cx, [bp+10]	; numero corrispondente letto
	
	;
    	mov ax,cx
	mov dh,2h
    div dh
    xor dh,dh

	cmp ah,0
	je NumeroPari
	
	NumeroDispari:
		;mov si, [bp+6] ; Sorg2
		;add si,cx ; mi posiziono in cx
		
		;lodsb

        mov ax,[si]

        cmp ax,0
        jne SeNonCiSonoDispari
        mov ax,[bx]
        cmp ax,0
        je FineLettura


SeNonCiSonoDispari:
        inc si
        ;inc bx
		stosb


		jmp FineFunzione

    

	NumeroPari:
		;mov si, [bp+8] ; Sorg1
		;add si,cx ; mi posiziono in cx

		;lodsb

        mov ax,[bx]

        cmp ax,0
        jne CiSonoPari

SeNonCiSonoPari:        
        mov ax,[si]
        cmp ax,0
        je FineLettura

CiSonoPari:
        inc bx
        ;inc si
		stosb
        
		jmp FineFunzione
        

FineFunzione:

	;mov [di+1], byte 0
	;mov ax,Dest
	;push ax
	;call ScriviStringa
	;add sp,2
    inc dl
	pop bp
	ret

ScriviStringa:
	push bp
	mov bp,sp
	mov ah,02h
	mov bx,[bp+4]
.AltroCarattere:
	mov dl,[bx]
	cmp dl,0
	je Fine
	int 21h
	inc bx
	jmp .AltroCarattere

Fine:
	pop bp
	ret

FineLettura:
	mov [di+1], byte 0
	mov ax,Dest
	push ax
	call ScriviStringa
	add sp,2

	mov ax, 4C00h
	int 21h
