SECTION data
	N: db 5
	V1: db 3, 7, 21, 22, 6
	V2: db 9, 2, 22, 11, 19
	Nmax: db 4
	S1: db "Valori superiori alla media maggiori di o uguali a Nmax",13,10,0
	S2: db "Valori superioti alla media minori di Nmax",13,10,0

SECTION text
..start:
	mov ax, data
	mov ds, ax
	mov es, ax

	xor ah,ah
	mov al,[N]
	push ax

	mov ax,V1
	push ax

	mov ax,V2
	push ax

	xor ah,ah
	mov al,[Nmax]
	push ax

	mov ax,S1
	push ax
	
	mov ax,S2
	push ax
	
	call ContaSeSuperioreMedia
	add sp,12

	mov ax, 4c00h
	int 21h

ContaSeSuperioreMedia:

	push bp
	mov bp,sp

	;[bp+4]; S2
	;[bp+6]; S1
	;mov bx,[bp+8]; Nmax
	mov di,[bp+10]; V2[0]
	mov si,[bp+12]; V1[0]

	mov cx,[bp+14]; N
	mov dx,[bp+14];temporaneo
	xor bx,bx
	xor ax,ax

CicloPerMedia:

	add al,[si]
	inc si
	loop CicloPerMedia
	div dl
	xor ah,ah
	xor dl,dl
	mov cx,[bp+14]; N
	;la media viene messa in al
	mov bx,[bp+8]

CicloPerConfrontoMediaConV2:
	cmp al,[di]
	;se media < v2
	jle MediaMinoreUgualeV2
	;se mi trovo qui vuol dire che V2>MEDIA
	cmp bx,[di];in bx c'è nmax
	
	V2MaggioreNmax:
		cmp bx,[di]
		jl NmaxMinore;se Nmax<V2[i]
	
		mov dx,[bp+4]
		push dx
		call ScriviStringa
		add sp,2		

		NmaxMinore:
		mov dx,[bp+6]
		push dx
		call ScriviStringa
		add sp,2


	inc di

	loop CicloPerConfrontoMediaConV2
	pop bp
	ret

MediaMinoreUgualeV2:
	inc di
	loop CicloPerConfrontoMediaConV2
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

	