SECTION data

Vett: db 3, -5, 7, 12, -3, 11, 22
N: db 7


SECTION text
..start:
	mov ax, data
	mov ds, ax
	mov es, ax
	
	xor dx,dx


Leggi:
	mov ah,00h
	int 16h

	cmp al,1bh
	je FineLettura

    	cmp al,78 ;N
    	je PremutoN
	
	cmp al,83 ;S
    	je ChiamaFunzione
		;se non sono N o S ricomincia
		jmp Leggi

ChiamaFunzione:
	mov ah,0eh
	;mov bx,00h
	int 10h
	
	mov ax, Vett
	push ax
	mov al,[N]
	push ax

	call ScambiaValori
	add sp,4
	inc dl
	jmp Leggi

PremutoN:
	inc dl
Continua:

	mov ah,0eh
	;mov bx,00h
	int 10h

	;metto il carattere letto
	jmp Leggi

ScambiaValori:
	push bp
	mov bp, sp
	
	mov cx,[bp+4]; metto N
	mov bx,[bp+6]; metto Vett
	add bx,dx
	
	cmp dx,cx
	je Fine
	mov ax,[bx+1]
	mov [bx],ax
	
	

Fine:
	pop bp
	ret

FineLettura:

	mov ax, 4C00h
	int 21h
