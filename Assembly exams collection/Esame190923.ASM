SECTION data

	Stringa: db 'ArchItEtTo',0


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
	sub al,30h ; trasformo l'ascii in numero
	push ax

	mov ax,Stringa
	push ax


	call VisualizzaCaratteri
	add sp,2

	jmp Leggi


VisualizzaCaratteri:
	push bp
	mov bp, sp

	mov si, [bp+4]	; Stringa
	mov cx, [bp+6]	; numero corrispondente letto
	
	add si,cx ; mi posiziono in cx
	
	mov ax,si
	push ax
	call ScriviStringa
	add sp,2
	

	pop bp
	ret

ScriviStringa:
	push bp
	mov bp,sp
	mov ah,02h
	mov bx,[bp+4]
.AltroCarattere:
	mov dl,[bx]
	int 21h
Fine:
	pop bp
	ret

FineLettura:

	mov ax, 4C00h
	int 21h
