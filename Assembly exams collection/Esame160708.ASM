SECTION data
	V1: dw 3, 7, -21, 22, 6
	V2: dw 9, 8, 22, 7, -9
	V3: dw -7, 15, 0, 31, 12
	N: db 5

SECTION text
..start:
	mov ax, data
	mov ds, ax
	mov es, ax

	mov ax, V1
	push ax
	mov ax, V2
	push ax
	mov ax, V3
	push ax
	xor ah,ah; e' un db
	mov al, [N]
	push ax

	call CalcolaValori
	add sp,8; perché ho fatto 4 push
	
	mov ah, 4ch
	mov al,0
	int 21h

CalcolaValori:
	push bp
	mov bp,sp
	
	mov cx, [bp+4]; N
	mov bx, [bp+6]; V3
	mov di, [bp+8]; V2 che punta a v2[0] non è ok
	mov si, [bp+10]; V1 che punta a V1[0] ok

	add di, [bp+4]
	add di, [bp+4]; qui V2 punta a V2[5] e devo decrementare di 1
	dec di
	dec di;dw quindi occupa 2 byte

	xor dx,dx ; lo userò come contatore per le volte in cui v1[i]+v2[n-i-1]>v3[i]

Ciclo:
	lodsw; adesso in ax ho v1, e lo scorro ogni volta
	add ax,[di]
	cmp ax,[bx]
	jle NonMaggiore
	inc dx
NonMaggiore:
	
	inc bx
	inc bx
	dec di
	dec di

	loop Ciclo
	pop bp
	ret
