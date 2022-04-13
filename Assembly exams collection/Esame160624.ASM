SECTION data
	Sorg: db 'BUONESAME',0
	Dest: resb 100
	Vett: db 3,-2,10,-2,0,-10,1,1,2

SECTION text
..start:
	mov ax, data
	mov ds, ax
	mov es, ax

	mov ax, Sorg
	push ax
	mov ax, Dest
	push ax
	mov ax, Vett
	push ax

	call ModificaStringa
	add sp,6; perché ho fatto 3 push

	mov ax,Dest
	push ax
	call ScriviStringa	
	add sp,2
	
	mov ah, 4ch
	mov al,0
	int 21h

ModificaStringa:
	push bp
	mov bp,sp
	mov bx,[bp+4] ; Vett
	mov di,[bp+6] ; Dest
	mov si,[bp+8] ; Sorg

RiempiDest:
	lodsb
	
	cmp al, 0
	je Fine
	xor ah,ah
	sub al,[bx] ; bx parte da 0
	cmp al, 'A'
	jb MettiMeno
	
	cmp al, 'Z'
	ja MettiPiu

	stosb; da al in di
	inc bx
	jmp RiempiDest

MettiMeno:
	mov al,'-'
	stosb; da al in di
	inc bx
	jmp RiempiDest
	
MettiPiu:
	mov al,'+'
	stosb; da al in di
	inc bx
	jmp RiempiDest

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
