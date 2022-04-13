SECTION data
	Stringa: resb 100


SECTION text
..start:
	mov ax, data
	mov ds, ax
	mov es, ax
	
	xor ch,ch;conta le vocali
	xor cl,cl;conta le lettere della stringa

Leggi:
	mov ah,00h
	int 16h

	cmp al,1bh
	je FineLettura
	
	mov ah,0eh
	mov bx,00h
	int 10h

	;metto il carattere letto
	xor ah,ah
	push ax

	mov ax,Stringa
	push ax


	call LeggiEModifica
	add sp,2
	inc cl

	jmp Leggi

FineLettura:
	;zero termino la stringa

	;xor ah, ah
	;mov al, cl
	;add si, ax
	
	
	mov [si+1], byte 0
	
	mov ax, Stringa
	push ax
	call ScriviStringa
	add sp,2

	mov ax, 4C00h
	int 21h

LeggiEModifica:
	push bp
	mov bp, sp

	mov si, [bp+4]	; Stringa
	mov dl, [bp+6]	; carattere letto
	
	xor ah,ah
	mov al,cl
	add si,ax;mi posiziono alla fine della stringa
	
	add dl,cl
	mov [si],dl
	mov ax,si
	call ControllaVocale
	
	pop bp
	ret
	
ControllaVocale:
	cmp dl,'a'
	je IncrementaContatore

	cmp dl,'e'
	je IncrementaContatore

	cmp dl,'i'
	je IncrementaContatore
	
	cmp dl,'o'
	je IncrementaContatore

	cmp dl,'u'
	je IncrementaContatore

	ret

IncrementaContatore:
	inc ch
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
