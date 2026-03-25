[org 0x0100]
jmp start
pcb: times 32*16 dw 0 ; space for 32 PCBs
stack: times 32*256 dw 0 ; space for 32 512 byte stacks
nextpcb: dw 1 ; index of next free pcb
current: dw 0 ; index of current pcb
lineno: dw 0 ; line number for next thread
notes dw 440, 494, 523, 587, 659, 698, 784
message: db 'LOADING _ _ _ _ _ _ _', 0
tap:db'TAP TO CONTINUE!!',0
oldtimer dd 0
    rect_pos1 dw 80   
    rect_pos2 dw 120   
    rect_pos3 dw 90     
    Birddirection db 'd'  
    BUFFER_SIZE equ 4000 
	rect_1u dw 10
	rect_1d dw 9
	rect_2u dw 10
	rect_2d dw 9
	rect_3u dw 5
	rect_3d dw 6
	reset_flag1 db 0      
    reset_flag2 db 0
    reset_flag3 db 0
	birdpos dw 12
	oldisr dd 0
	key db 0
	paused db 0
	grass1 dw 20
	grass2 dw 50
	counter dw 0
	stay dw 0
	exit dw 0
	dead dw 0
	score dw 0 
	moving dw 0
	crossed dw 0
	width dw 8
	your db 'YOUR SCORE',0
message1: db 'Ahmad Ali 23L0901', 0
message2: db 'Hamza Imtiaz 23L0689', 0
message_center: db 'DESSERT EAGLE', 0
press_key: db 'Press any key to Start!!!', 0
message_prompt: db 'Do you want to continue or exit?', 0
message_options: db 'Press C to continue or X to exit', 0
game_over_msg: db 'GAME OVER!', 0
instructions:db'GAME INSTRUCTIONS!!!!!!!',0
messageu db "Press 'U' key to jump ", 0
messagep db "Press 'P' to pause  ", 0
confirmation db 'DO YOU WANT TO EXIT OR CONTINUE',0
scoree db 'SCORE',0


firstLine: db"   ____    _    __  __ _____    _____     _______ ____  "
secondLine: db"  / ___|  / \  |  \/  | ____|  / _ \ \   / / ____|  _ \ "
thirdLine: db" | |  _  / _ \ | |\/| |  _|   | | | \ \ / /|  _| | |_) |"
fourthLine: db" | |_| |/ ___ \| |  | | |___  | |_| |\ V / | |___|  _ < "
fifthLine: db"  \____/_/   \_\_|  |_|_____|  \___/  \_/  |_____|_| \_\"



firstLine1: db "      DDDD   EEEEE  SSSSS  EEEEE  RRRRR   TTTTTT "
secondLine1: db "      D   D  E      S      E      R   R     T   "
thirdLine1: db "      D   D  EEEE   SSSSS  EEEE   RRRRR     T   "
fourthLine1: db "      D   D  E          S  E      R  R      T   "
fifthLine1: db "      DDDD   EEEEE  SSSSS  EEEEE  R   R     T   "
sixthLine1: db "                           "

firstLine1e:   db "           EEEEE   AAAAA   GGGGG   L        EEEEE  "
secondLine1e:  db "           E       A   A   G       L        E      "
thirdLine1e:   db "           EEEE    AAAAA   G  GG   L        EEEE   "
fourthLine1e:  db "           E       A   A   G   G   L        E      "
fifthLine1e:   db "           EEEEE   A   A   GGGGG   LLLLL    EEEEE  "
sixthLine1e:   db "                                              "


section .bss
    buffer resb BUFFER_SIZE 
section .text
clrscreen:
push cs
pop ds
    push ax
    push di
    mov di, buffer         
clrblue:
    mov word [di], 0x3220  
    add di, 2
    cmp di, buffer + BUFFER_SIZE
    jne clrblue
    pop di
    pop ax
    ret
printscorebound:
push cs
pop ds
pusha
mov di,buffer
mov cx,80
colour:mov word[di],0x6620
add di,2
loop colour
mov di,buffer
add di,68
mov cx,6
mov ah,0X4E
mov si,scoree
nextchar:mov al,[si]
mov word[di],ax
add di,2
add si,1
loop nextchar
popa
ret
printnum:
push cs
pop ds
push bp
mov bp,sp
pusha
mov di,buffer
add di,80
mov ax,[bp+4]
mov bx,10
mov cx,0
nextdigit:mov dx,0
div bx
add dl,0x30
push dx
inc cx
cmp ax,0
jnz nextdigit
xor dx,dx
nextpos:pop dx
mov dh,0xCE
mov word[di],dx
add di,2
loop nextpos
popa
pop bp
ret 2
printscore:
push cs
pop ds
push word[score]
call printnum
ret
printnumend:
push cs
pop ds
push bp
mov bp,sp
pusha
mov ax,0xB800
mov es,ax
mov di,2480
mov ax,[bp+4]
mov bx,10
mov cx,0
nextdigitend:mov dx,0
div bx
add dl,0x30
push dx
inc cx
cmp ax,0
jnz nextdigitend
xor dx,dx
nextposend:pop dx
mov dh,0x4E
mov word[es:di],dx
add di,2
loop nextposend
popa
pop bp
ret 2
printscoreend:
push cs
pop ds
push word[score]
call printnumend
ret 

; Draw upper green rectangles at a given position in the buffer
printgrass:
push cs
pop ds
push bp
mov bp,sp
pusha
mov dx,24
mov al,80
mul dx
add ax,[bp+4]
shl ax,1
mov di,buffer
add di,ax
mov ax ,0x2220
mov [di],ax
mov [di-160],ax
mov [di-320],ax
mov [di-480],ax
mov [di-162],ax
mov [di-324],ax
mov [di-486],ax
mov [di-158],ax
mov [di-316],ax
mov [di-474],ax
popa
pop bp
ret 2
printbird:
push cs
pop ds
push bp
mov bp,sp
    push es
    push ax
    push di
	mov al,80
	mul word[bp+4]
	add ax,40
	shl ax,1
    ;mov ax,0x40E6
    ;mov es,ax
    mov di,buffer
    ;mov word[es:di],0X40E6
	add di,ax
	 mov ax,0x14E6
	mov [di],ax
	mov [di-2],ax
	mov [di+2],ax
    pop di
    pop ax
    pop es
	pop bp
    ret 2
upgreen:
push cs
pop ds
    push bp 
    mov bp, sp
    push ax
    push cx
    push dx
    push di
    push si
    mov si, -1
    mov bx, 0
	cmp  word[bp+4] ,80
	ja wrap
	;cmp  word[bp+4] ,72
	;jbe widthh
	;mov dx,79
	;sub dx, word[bp+4]
	;mov word[width],dx
	;jmp pos
	;widthh:
	;mov word[width],8
pos:
    add si, 1   
    mov ax, 0    
    mov al, 80          
    mul si
    add ax, word[bp+4] 
    shl ax, 1  
mov di,buffer	
    add di, ax 
    mov ax, 0x4020     
    mov cx, 0
    add bx, 1            
    cmp bx, word[bp+6]    
    ja endgreen
clr:
    mov [di], ax
    add di, 2
    add cx, 1
    cmp cx, word[width]
    ja pos
    jmp clr
endgreen:
wrap:
    pop si
    pop di
    pop dx
    pop cx
    pop ax
    pop bp
    ret 4

; Draw lower green rectangles at a given position in the buffer
downgreen:
push cs
pop ds
    push bp
    mov bp, sp
    push ax
    push cx
    push dx
    push di
    push si
    mov si, 25         ; Start drawing from line 14
    mov bx, 0
		cmp  word[bp+4] ,80
	ja wrapp
	;cmp  word[bp+4] ,72
	;jbe widthhh
	;mov dx,79
	;sub dx, word[bp+4]
	;mov word[width],dx
	;jmp pos
	;widthhh:
	;mov word[width],8
pos_down:
    sub si,1
    mov ax, 0
    mov al, 80
    mul si
    add ax, word[bp+4]  
    shl ax, 1
	;add ax,buffer
    mov di, buffer
	add di,ax
    mov ax, 0x4020      
    mov cx, 0
    add bx, 1
    cmp bx,word[bp+6]       
    ja end_downgreen
clr_down:
    mov [di], ax
    add di, 2
    add cx, 1
    cmp cx, 8          
    ja pos_down 
    jmp clr_down
end_downgreen:
wrapp:
    pop si
    pop di
    pop dx
    pop cx
    pop ax
    pop bp
    ret 4

; Draw the floor with scrolling effect
printfloor:
push cs
pop ds
    push ax
    push di
    push cx
    mov cx, 0
    mov di, buffer + 3840 ; Floor starts at line 22 in 80x25 mode

    ; Apply floor offset to start position
    add di, 0
    
fillfloor:
push cs
pop ds
    mov word [di], 0x6020 ; Floor character (background color)
    add cx, 2
    cmp cx, 10
    je star
    add di, 2
    cmp di, buffer + BUFFER_SIZE
    jne fillfloor
    pop cx
    pop di
    pop ax
    ret

star:
push cs
pop ds
    mov word[di], 0x6A2A   ; Star character in the floor
    mov cx, 0
    add di, 2
    cmp di, buffer + BUFFER_SIZE
    jne fillfloor
    pop cx
    pop di
    pop ax
    ret
update_screen:
push cs
pop ds
    push es
    push di  
	push ax
    mov ax, 0xb800
    mov es, ax
    mov di, 0
    mov si, buffer         
    mov cx, BUFFER_SIZE /2
copy_buffer:
    mov ax, [si]
    mov [es:di], ax
    add si, 2
    add di, 2
    loop copy_buffer
	pop ax
    pop di
    pop es
    ret
collision:
push cs
pop ds
    pusha
    cmp word [birdpos], 23         
    je game_over
    
    mov ax, [rect_pos1]          
    cmp ax, 32                    
    jl score_pillar1               
    cmp ax, 40
    jg check_pillar2              

    mov bx, [rect_1u]              
    cmp word [birdpos], bx        
    jle game_over                

    mov cx, [rect_1d]              
    mov dx, 26            
    sub dx, cx                     
    cmp word [birdpos], dx         
    jge game_over                  

score_pillar1:
    cmp ax, 32                     
    jne check_pillar2             
    call update_score             

check_pillar2:
    mov ax, [rect_pos2]            
    cmp ax, 32
    jl score_pillar2
    cmp ax, 40
    jg check_pillar3

    mov bx, [rect_2u]
    cmp word [birdpos], bx
    jle game_over

    mov cx, [rect_2d]
    mov dx, 26
    sub dx, cx
    cmp word [birdpos], dx
    jge game_over

score_pillar2:
    cmp ax, 32
    jne check_pillar3
    call update_score

check_pillar3:
    mov ax, [rect_pos3]            ; Horizontal position of the third pillar
    cmp ax, 32
    jl score_pillar3
    cmp ax, 40
    jg no_collision

    mov bx, [rect_3u]
    cmp word [birdpos], bx
    jle game_over

    mov cx, [rect_3d]
    mov dx, 26
    sub dx, cx
    cmp word [birdpos], dx
    jge game_over

score_pillar3:
    cmp ax, 32
    jne no_collision
    call update_score

no_collision:
    popa
    ret

update_score:
push cs
pop ds
    pusha
    mov ax, [score]               
    inc ax                        
    mov [score], ax               
    popa
    ret

game_over:
push cs
pop ds
    mov word [dead], 1            
    popa
    ret
animate:
push cs
pop ds
mainloop:
call collision
cmp word[dead],1
je exiit
cmp word[exit],1
je exiit
cmp byte[paused],1
je pausee
    call clrscreen 
	;call printfloor
	mov ax, [grass1]
    add ax, 1
    cmp ax, 76
    jb grass1_update
    mov ax, 0
grass1_update:
    mov [grass1], ax
    mov ax, [grass2]
    add ax, 1
    cmp ax, 76
    jb grass2_update
    mov ax, 0
grass2_update:
    mov [grass2], ax
    mov dx, [grass1]
    push dx
    call printgrass
    mov dx, [grass2]
    push dx
    call printgrass
    cmp byte [reset_flag1], 1
    jne skip_update1
    mov byte [reset_flag1], 0  
    mov ax, [rect_1u]
    add ax, 1
    cmp ax, 9
    jle skip1_reset
    mov ax, 8
skip1_reset:
    mov [rect_1u], ax

    mov ax, [rect_1d]
    sub ax, 1
    cmp ax, 7
    jge skip1d_reset
    mov ax, 12
skip1d_reset:
    mov [rect_1d], ax
skip_update1:
    ; Draw first pair
    mov dx, [rect_1u]
    push dx
    mov dx, [rect_pos1]
    push dx
    call upgreen
   ;call delay
    mov dx, [rect_1d]
    push dx
    mov dx, [rect_pos1]
    push dx
    call downgreen
    cmp byte [reset_flag2], 1
    jne skip_update2
    mov byte [reset_flag2], 0
    mov ax, [rect_2u]
    add ax, 1
    cmp ax, 11
    jle skip2_reset
    mov ax, 7
skip2_reset:
    mov [rect_2u], ax

    mov ax, [rect_2d]
    sub ax, 1
    cmp ax, 6
    jge skip2d_reset
    mov ax, 11
skip2d_reset:
    mov [rect_2d], ax
skip_update2:
    mov dx, [rect_2u]
    push dx
    mov dx, [rect_pos2]
    push dx
    call upgreen
   ; call delay
    mov dx, [rect_2d]
    push dx
    mov dx, [rect_pos2]
    push dx
    call downgreen
    cmp byte [reset_flag3], 1
    jne skip_update3
    mov byte [reset_flag3], 0
    mov ax, [rect_3u]
    add ax, 1
    cmp ax, 15
    jle skip3_reset
    mov ax, 6
skip3_reset:
    mov [rect_3u], ax
    mov ax, [rect_3d]
    sub ax, 1
    cmp ax, 4
    jge skip3d_reset
    mov ax, 10
skip3d_reset:
    mov [rect_3d], ax
skip_update3:
    mov dx, [rect_3u]
    push dx
    mov dx, [rect_pos3]
    push dx
    call upgreen
   ; call delay
    mov dx, [rect_3d]
    push dx
    mov dx, [rect_pos3]
    push dx
    call downgreen
call printscorebound
call printscore
    call printfloor
	mov dx,[birdpos]
	push dx
	call delay
	call delay
    call printbird
    call update_screen
   ;call delay
	mov ax,[birdpos]
	;cmp word[stay],1
	;je out
	cmp byte[Birddirection],'U'
	je incre
	cmp byte  [Birddirection], 'd'
	jne out
	add ax,1
	mov [birdpos],ax
	;mov word[stay],1
	;cmp word[birdpos],23
	;je change1
	jmp out
	change1: 
	mov word[birdpos],12
	jmp out
	incre:
	;cmp word[stay],1
	;je out
	sub ax,1
	mov [birdpos],ax
	;mov byte[Birddirection],'d'
	cmp word[birdpos],0
	jbe change
	jmp out
	change:add ax,1
	mov word[birdpos],ax
	jmp out
	out:
    mov ax, [rect_pos1]
    sub ax, 1
    cmp ax, 0
    jg skip1
    mov ax, 80
    mov byte [reset_flag1], 1 
skip1:
    mov [rect_pos1], ax
    mov ax, [rect_pos2]
    sub ax, 1
    cmp ax, 0
    jg skip2
    mov ax, 80
    mov byte [reset_flag2], 1
skip2:
    mov [rect_pos2], ax
    mov ax, [rect_pos3]
    sub ax, 1
    cmp ax, 0
    jg skip3
    mov ax, 80
    mov byte [reset_flag3], 1
skip3:
    mov [rect_pos3], ax
	;call collision
	initial:
    jmp mainloop
	pausee:
	call startprompt
	jmp initial
	exiit:
	call startend
	ret 
delay:
push cs
pop ds
    push cx
    mov cx, 0xffff
delay_loop:
    loop delay_loop
    pop cx
    ret
	startend:
	push cs
pop ds
	pusha
    mov ah, 0x01
    mov cx, 0x2607
    int 0x10
    mov ax, 0xB800
    mov es, ax
    mov di, 0
    mov cx, 2000
backgroundd_loop:
    mov al, ' '
    mov ah, 0x00
    stosw
    loop backgroundd_loop
	call printText
    mov ah, 0x13
    mov al, 1
    mov bh, 0
    mov bl, 0xCE
    mov cx, 10
    mov dx, 0x0C23
    push ds
    pop es
    mov bp, game_over_msg
    int 0x10
	call printscoreend
	mov ax,0xb800
	mov es,ax
	mov di,2454
	mov ax,0
mov cx,11
mov ah,0X4E
mov si,your
nextcharr:mov al,[si]
mov word[es:di],ax
add di,2
add si,1
loop nextcharr
	popa
	ret
	instructionscreen:
	push cs
pop ds
	pusha
	 mov ah, 0x01
    mov cx, 0x2607
   int 0x10
    mov ax, 0xB800
    mov es, ax
    mov di, 0
    mov cx, 2000
background_looppp:
    mov al, ' '
    mov ah, 0x44
    stosw
    loop background_looppp
	mov ah, 0x13
    mov al, 1
    mov bh, 0
    mov bl, 0x4E
    mov cx, 23
    mov dx, 0x1203    
    push ds
    pop es
    mov bp, messageu
    int 0x10
    mov ah, 0x13
    mov al, 1
    mov bh, 0
    mov bl, 0x4E
    mov cx, 21
    mov dx, 0x1403     
    push ds
    pop es
    mov bp, messagep
    int 0x10
	mov ah, 0x13
    mov al, 1
    mov bh, 0
    mov bl, 0x4E
    mov cx, 25
    mov dx, 0x0C03

    push ds
    pop es
    mov bp, press_key
    int 0x10
mov ah, 0x13
    mov al, 1
    mov bh, 0
    mov bl, 0x4E
    mov cx, 20
    mov dx, 0x0167

    push ds
    pop es
    mov bp, instructions
    int 0x10
	xor ax,ax
   mov ah,0x00
   int 0x16
    popa                   
    ret  
startintro:
push cs
pop ds
pusha
    mov ah, 0x01
    mov cx, 0x2607
   int 0x10
    mov ax, 0xB800
    mov es, ax
    mov di, 0
    mov cx, 2000
background_loop:
    mov al, ' '
    mov ah, 0x00
    stosw
    loop background_loop
call printRectangle
call printTextstart
call printTextstartE
    mov ah, 0x13
    mov al, 1
    mov bh, 0
    mov bl, 0x4E
    mov cx, 17
    mov dx, 0x0000

    push ds
    pop es
    mov bp, message1
    int 0x10

    mov ah, 0x13
    mov al, 1
    mov bh, 0
    mov bl, 0x4E
    mov cx, 20
    mov dx, 0x003C

    push ds
    pop es
    mov bp, message2
    int 0x10

   ; mov ah, 0x13
    ;mov al, 1
    ;mov bh, 0
    ;mov bl, 0x4E
    ;mov cx, 14
    ;mov dx, 0x0A1E

    ;push ds
    ;pop es
   ; mov bp, message_center
    ;int 0x10
 mov ah, 0x00
    int 0x16
	popa
	ret
	startprompt:
    mov ah, 0x01
    mov cx, 0x2607
    int 0x10

    mov ax, 0xB800
    mov es, ax
    mov di, 0

    mov cx, 2000
background_loopp:
    mov al, ' '
    mov ah, 0x44
    stosw
    loop background_loopp

    mov ah, 0x13
    mov al, 1
    mov bh, 0
    mov bl, 0x4E
    mov cx, 33
    mov dx, 0x0A14
    push ds
    pop es
    mov bp, message_prompt
    int 0x10
    mov ah, 0x13
    mov al, 1
    mov bh, 0
    mov bl, 0x4E
    mov cx, 32
    mov dx, 0x0C16
    push ds
    pop es
    mov bp, message_options
    int 0x10
	ret
		loading:
pusha
    mov ah, 0x01
    mov cx, 0x2607
    int 0x10
    
    mov ax, 0xB800
    mov es, ax
    mov di, 0
    mov cx, 2000
background_loopo:
    mov al, ' '
    mov ah, 0x4E
    stosw
    loop background_loopo

    mov al, 0x5F
    mov ah, 0x4E
    mov di, 0
    mov cx, 80
underscore_borders:
    stosw
    loop underscore_borders

    mov di, 3680
    mov cx, 80
underscore_borderz:
    stosw
    loop underscore_borderz
	mov ax,0x0020
	mov di,1810
	mov cx ,30
black_borderz:
    stosw
    loop black_borderz
		mov ax,0x0020
	mov di,1970
	mov cx ,30
black_borderzz:
    stosw
    loop black_borderzz
		mov ax,0x0020
	mov di,2130
	mov cx ,30
black_borderzzz:
    stosw
    loop black_borderzzz
    mov si, message
    mov di,1980
mov ax,0xb800
mov es,ax
xor ax,ax
mov ah,0x0E
print_char:
    mov al, [si]
    cmp al, 0
    je done_printing
	mov word[es:di],ax
   ; mov ah, 0x0E
   ; mov bh, 0
   ; mov bl, 0x4E
   ; mov cx, 1
   ; mov dx, di
    ;push ds
    ;pop es
    ;mov bp, si
   ; int 0x10

    mov cx, 0xFFFF
delay_loop12:
    loop delay_loop12
    mov cx, 0xFFFF
delay_loop22:
    loop delay_loop22
    mov cx, 0xFFFF
delay_loop3:
    loop delay_loop3
    mov cx, 0xFFFF
delay_loop4:
    loop delay_loop4
    mov cx, 0xFFFF
delay_loop5:
    loop delay_loop5
    mov cx, 0xFFFF
delay_loop6:
    loop delay_loop6
    mov cx, 0xFFFF
delay_loop7:
    loop delay_loop7
    mov cx, 0xFFFF
delay_loop8:
    loop delay_loop8
    mov cx, 0xFFFF
delay_loop9:
    loop delay_loop9
    mov cx, 0xFFFF
delay_loop10:
    loop delay_loop10
    add di,2
    inc si
    jmp print_char

done_printing:
    mov ah, 0x13
    mov al, 1
    mov bh, 0
    mov bl, 0xCE
    mov cx, 17
    mov dx, 0x1403
    push ds
    pop es
    mov bp, tap
    int 0x10
    mov ah, 0x00
    int 0x16
    popa
    ret
kbsir:
push cs
pop ds
    push ax
    in al, 0x60
    cmp al, 0x16            ; Check for 'U' key press (up direction)
    jne nextcomm
    mov byte [Birddirection], 'U'
    mov word [counter], 0  
    ;mov word [stay], 0
    jmp endd
	nextcomm:
    cmp al, 0x96        ; Example key for other actions
    jne nextcom
	 mov byte [Birddirection], 's'
    mov word [stay], 1
    jmp endd
nextcom:
    cmp al, 0x19          ; Pause key
    jne next
    mov byte [paused], 1
    jmp endd
next:
    cmp al, 0x2e           ; Resume key
    jne chkexit
    mov byte [paused], 0
    jmp endd
chkexit: cmp al,0x2d
jne chk
cmp byte [paused], 1
jne endd
mov word[exit],1
jmp endd
chk:
    in al, 0x60
    mov byte [key], 1
endd:
    mov al, 0x20
    out 0x20, al
    pop ax
    iret
	
	print:
	push cs
pop ds
	call clrscreen
	call printscorebound
	call printscore
	mov dx,[cs:birdpos]
	push dx
    call printbird
	call printfloor
	
	 mov dx, [rect_1u]
    push dx
    mov dx, [rect_pos1]
    push dx
    call upgreen
    mov dx, [rect_1d]
    push dx
    mov dx, [rect_pos1]
    push dx
    call downgreen
	mov dx,[grass1]
	push dx
	call printgrass
	mov dx,[grass2]
	push dx
	call printgrass
	 call update_screen
	; mov ah, 0x00
   ; int 0x16
	
	ret
	timer:
	push ds
			push bx
			push cs
			pop ds ; initialize ds to data segment
    inc word [counter]         
    cmp word [counter], 9
   ; mov word [stay], 1    
    jne outt
    mov byte [Birddirection], 'd' 
    mov word [counter], 0    
    ;mov word [stay], 0	
outt:
			mov bx, [current] ; read index of current in bx
			shl bx, 1
			shl bx, 1
			shl bx, 1
			shl bx, 1
			shl bx, 1 ; multiply by 32 for pcb start
			
			mov [pcb+bx+0], ax ; save ax in current pcb
			mov [pcb+bx+4], cx ; save cx in current pcb
			mov [pcb+bx+6], dx ; save dx in current pcb
			mov [pcb+bx+8], si ; save si in current pcb
			mov [pcb+bx+10], di ; save di in current pcb
			mov [pcb+bx+12], bp ; save bp in current pcb
			mov [pcb+bx+24], es ; save es in current pcb
			pop ax ; read original bx from stack
			mov [pcb+bx+2], ax ; save bx in current pcb
			pop ax ; read original ds from stack
			mov [pcb+bx+20], ax ; save ds in current pcb
			pop ax ; read original ip from stack
			mov [pcb+bx+16], ax ; save ip in current pcb
			pop ax ; read original cs from stack
			mov [pcb+bx+18], ax ; save cs in current pcb
			pop ax ; read original flags from stack
			mov [pcb+bx+26], ax ; save cs in current pcb
			mov [pcb+bx+22], ss ; save ss in current pcb
			mov [pcb+bx+14], sp ; save sp in current pcb
			
			mov bx, [pcb+bx+28] ; read next pcb of this pcb
			mov [current], bx ; update current to new pcb
			mov cl, 5
			shl bx, cl ; multiply by 32 for pcb start
			
			mov cx, [pcb+bx+4] ; read cx of new process
			mov dx, [pcb+bx+6] ; read dx of new process
			mov si, [pcb+bx+8] ; read si of new process
			mov di, [pcb+bx+10] ; read diof new process
			mov bp, [pcb+bx+12] ; read bp of new process
			mov es, [pcb+bx+24] ; read es of new process
			mov ss, [pcb+bx+22] ; read ss of new process
			mov sp, [pcb+bx+14] ; read sp of new process
			push word [pcb+bx+26] ; push flags of new process
			push word [pcb+bx+18] ; push cs of new process
			push word [pcb+bx+16] ; push ip of new process
			push word [pcb+bx+20]
			
			mov al, 0x20
			out 0x20, al 
			
			mov ax, [pcb+bx+0] 
			mov bx, [pcb+bx+2] 
			
			pop ds 
			
			iret 
			initpcb: 	
			push cs
			pop ds
			push bp
			mov bp, sp
			push ax
			push bx
			push cx
			push si
			
			mov bx, [nextpcb] ; read next available pcb index
			cmp bx, 32 ; are all PCBs used
			je exitx ; yes, exit
			
			mov cl, 5
			shl bx, cl ; multiply by 32 for pcb start ix2^5 
			
			mov ax, [bp+6] ; read segment parameter
			mov [pcb+bx+18], ax ; save in pcb space for cs
			mov ax, [bp+4] ; read offset parameter
			mov [pcb+bx+16], ax ; save in pcb space for ip
			mov [pcb+bx+22], ds ; set stack to our segment
			
			mov si, [nextpcb] ; read this pcb index
			mov cl, 9
			shl si, cl ; multiply by 512...ix2^9 (512)
			add si, 256*2+stack ; end of stack for this thread
			;mov ax, [bp+4] ; read parameter for subroutine
            ;sub si, 2 ; decrement thread stack pointer
			;mov [si], ax ; pushing param on thread stack
			sub si, 2 ; space for return address
			mov [pcb+bx+14], si ; save si in pcb space for sp
			
			mov word [pcb+bx+26], 0x0200 ; initialize thread flags
			mov ax, [pcb+28] ; read next of 0th thread in ax
			mov [pcb+bx+28], ax ; set as next of new thread
			
			mov ax, [nextpcb] ; read new thread index
			mov [pcb+28], ax ; set as next of 0th thread
			
			inc word [nextpcb] ; this pcb is now used
			
			exitx: pop si
			pop cx
			pop bx
			pop ax
			pop bp
			ret 4
start:
;

     mov word [rect_pos1], 60
     mov word [rect_pos2],  90
     mov word [rect_pos3], 110
	 mov word[rect_1u] , 10
	 mov word[rect_1d] ,9
	 mov word[rect_2u] ,13
	 mov word[rect_2d], 8
	 mov word[rect_3u] ,11
	 mov word[rect_3d] ,8
	 mov word[birdpos],12
	 call startintro
	 call instructionscreen
	  call loading
	 xor ax,ax
	 mov es,ax
	 mov ax,[es:9*4]
	 mov[oldisr],ax
	 mov ax,[es:9*4+2]
	 mov[oldisr+2],ax
	 xor ax,ax
	  mov ax,[es:8*4]
	 mov[oldtimer],ax
	 mov ax,[es:8*4+2]
	 mov[oldtimer+2],ax
	 xor ax,ax
	 xor dx,dx
	 cli
	 mov word[es:9*4],kbsir
	 mov [es:9*4+2],cs
	 sti
	 keypresseddd:
	 cmp byte[key],1
	 jne keypresseddd
	 call print
	 mov byte[key],0
	 keypressed: 
	 cmp byte[key],1
	 jne keypressed
	 xor ax,ax
	; mov ax, 1100
;out 0x40, al
;mov al, ah
;out 0x40, al
	 xor ax, ax
mov es, ax ; point es to IVT base
cli
mov word [es:8*4], timer
mov [es:8*4+2], cs ; hook timer interrupt
sti
push cs 
mov ax, animate
push ax 
call initpcb 
push cs
mov ax, sound
push ax 
call initpcb 
hang:
cmp word[cs:dead],1
je jjj
jmp hang
jjj:
mov al, 11111101b    ; Clear bit 1 (Speaker Gate) while keeping other bits unchanged
in  al, 61h            ; Read current state of port 61h
and al, 0FEh           ; Clear bit 1 (Speaker Gate)
out 61h, al            ; Write back to port 61h

; Reset Timer Channel 2 of the PIT
mov al, 10110110b    ; Control word: Select Channel 2, Latch Command
out 43h, al            ; Send control word to PIT command register
mov al, 0              ; Send initial count low byte
out 42h, al            ; Write to Channel 2 data port
mov al, 0              ; Send initial count high byte
out 42h, al   
xor ax,ax
mov es,ax
mov ax,[cs:oldtimer]
mov bx,[cs:oldtimer+2]
cli
mov [es:8*4],ax
mov [es:8*4+2],bx
sti
xor ax,ax
mov es,ax
mov ax,[cs:oldisr]
mov bx,[cs:oldisr+2]
cli
mov [es:9*4],ax
mov [es:9*4+2],bx
sti
  mov ax,0x4c00
    int 0x21
	sound:
	push cs
pop ds
    push ax
    infinite_sound_loop:
	cmp  byte[cs:dead] ,1
	je fin
        mov al, 182
        out 43h, al
        mov bx, 1193180
        div bx
        out 42h, al
        mov al, ah
        out 42h, al
        in al, 61h
        or al, 00000011b
        out 61h, al
        mov bx, 3
    delay_loop1:
        mov cx, 65535
    delay_loop2:
        dec cx
        jne delay_loop2
        dec bx
        jne delay_loop1
        in al, 61h
        and al, 11111100b
        out 61h, al
        jmp infinite_sound_loop
fin:
    pop ax
    ret
	unhookkbsir:
	push cs
	pop ds
	pusha
	xor ax,ax
	xor bx,bx
mov es,ax
mov ax,[oldisr]
mov bx,[oldisr+2]
cli
mov [es:8*4],ax
mov [es:8*4+2],bx
sti
popa
ret
	unhookoldtimer:
	push cs
	pop ds
	pusha
	xor ax,ax
	xor bx,bx
mov es,ax
mov ax,[oldtimer]
mov bx,[oldtimer+2]
cli
mov [es:8*4],ax
mov [es:8*4+2],bx
sti
popa
ret


printText:
    push bp 
    mov bp, sp
    push es
    push di
    push ax
    push si
    push cx
    push dx
    push bx

    mov ax, 0xb800
    mov es, ax   

;1st line
    mov si, firstLine ;msg
    push si
    mov cx, 56 ;len
    push cx
    mov di, 1144 ;postion
    push di
    call printLineGameOver

;2nd line
    mov si, secondLine ;msg
    push si
    mov cx, 56 ;len
    push cx
    mov di, 1304 ;postion
    push di
    call printLineGameOver
;3rd line
    mov si, thirdLine ;msg
    push si
    mov cx, 56 ;len
    push cx
    mov di, 1464 ;postion
    push di
    call printLineGameOver
;4th line
    mov si, fourthLine ;msg
    push si
    mov cx, 56 ;len
    push cx
    mov di, 1624 ;postion
    push di
    call printLineGameOver
;5th line
    mov si, fifthLine ;msg
    push si
    mov cx, 56 ;len
    push cx
    mov di, 1784 ;postion
    push di
    call printLineGameOver                                            


    pop bx
    pop dx
    pop cx
    pop si
    pop ax
    pop di
    pop es
    pop bp
    ret 
	
	
	printLineGameOver:
    push bp
    mov bp, sp
    push si
    push cx
    push di
    push ax
    push es

    mov ax, 0xb800
    mov es, ax  

    mov ah, 0x8E
    mov si, [bp + 8]
    mov cx, [bp + 6]
    mov di, [bp + 4]
    

nextLetterGameOver: 
    mov al, [si]
    mov [es:di], ax
    add di, 2
    add si, 1
    loop nextLetterGameOver

    pop es
    pop ax
    pop di
    pop cx
    pop si
    pop bp
    ret 6
printRectangle:	
push bp
mov bp,sp
pusha

		mov ax, 0xb800
		mov es, ax 		; point es to video base

		mov al, 80 		; load al with columns per row
		mov dl, 2
		mul dl 	        ; multiply with row number
		add ax, 3 	    ; add col
		shl ax, 1 		; turn into byte offset
		mov di, ax 		; point di to required location
		mov ah, 0x44 		   ; load attribute in ah
		mov cx, 72

topLine:	
mov al, 0x2D 		; ASCII of '-'
		mov [es:di], ax 	; show this char on screen
		add di, 2 		; move to next screen location 
		call sleep;
		loop topLine		; repeat the operation cx times

		mov cx, 20

rightLine:	mov al, 0x7c 		; ASCII of '|'
		mov [es:di], ax 	; show this char on screen
		add di, 160 		; move to next screen location 		
		call sleep;
		loop rightLine		; repeat the operation cx times
		
		mov cx, 72

bottomLine:	mov al, 0x2D 		; ASCII of '-'
		mov [es:di], ax 	; show this char on screen
		sub di, 2 		; move to next screen location 
		call sleep;
		loop bottomLine		; repeat the operation cx times

		mov cx, 20
		;sub cx, 2

leftLine:	mov al, 0x7c 		; ASCII of '|'
		mov [es:di], ax 	; show this char on screen
		sub di, 160 		; move to next screen location 		
		call sleep;
		loop leftLine		; repeat the operation cx times

		popa
		pop bp
		ret
;---------------------------------------------------------------------------
sleep:		push cx
		mov cx, 0xFFFF
Sleepdelay:		loop Sleepdelay
		pop cx
		ret
		printTextstart:
    push bp 
    mov bp, sp
    push es
    push di
    push ax
    push si
    push cx
    push dx
    push bx

    mov ax, 0xb800
    mov es, ax   

;1st line
    mov si, firstLine1 ;msg
    push si
    mov cx, 49;len
    push cx
    mov di, 1144 ;postion
    push di
    call printLinestart

;2nd line
    mov si, secondLine1 ;msg
    push si
    mov cx, 49 ;len
    push cx
    mov di, 1304 ;postion
    push di
    call printLinestart
;3rd line
    mov si, thirdLine1 ;msg
    push si
    mov cx, 49;len
    push cx
    mov di, 1464 ;postion
    push di
    call printLinestart
;4th line
    mov si, fourthLine1 ;msg
    push si
    mov cx, 49 ;len
    push cx
    mov di, 1624 ;postion
    push di
    call printLinestart
;5th line
    mov si, fifthLine1 ;msg
    push si
    mov cx, 49;en
    push cx
    mov di, 1784 ;postion
    push di
    call printLinestart                                        


    pop bx
    pop dx
    pop cx
    pop si
    pop ax
    pop di
    pop es
    pop bp
    ret 
	
	
	printLinestart:
    push bp
    mov bp, sp
    push si
    push cx
    push di
    push ax
    push es

    mov ax, 0xb800
    mov es, ax  

    mov ah, 0x0E
    mov si, [bp + 8]
    mov cx, [bp + 6]
    mov di, [bp + 4]
    

nextLetterstart: 
    mov al, [si]
    mov [es:di], ax
    add di, 2
    add si, 1
    loop nextLetterstart

    pop es
    pop ax
    pop di
    pop cx
    pop si
    pop bp
    ret 6
			printTextstartE:
    push bp 
    mov bp, sp
    push es
    push di
    push ax
    push si
    push cx
    push dx
    push bx

    mov ax, 0xb800
    mov es, ax   

;1st line
    mov si, firstLine1e ;msg
    push si
    mov cx, 49;len
    push cx
    mov di, 2104 ;postion
    push di
    call printLinestartE

;2nd line
    mov si, secondLine1e ;msg
    push si
    mov cx, 49 ;len
    push cx
    mov di, 2264 ;postion
    push di
    call printLinestartE
;3rd line
    mov si, thirdLine1e ;msg
    push si
    mov cx, 49;len
    push cx
    mov di, 2424 ;postion
    push di
    call printLinestartE
;4th line
    mov si, fourthLine1e ;msg
    push si
    mov cx, 49 ;len
    push cx
    mov di, 2584 ;postion
    push di
    call printLinestartE
;5th line
    mov si, fifthLine1e ;msg
    push si
    mov cx, 49;en
    push cx
    mov di, 2744 ;postion
    push di
    call printLinestartE                                      


    pop bx
    pop dx
    pop cx
    pop si
    pop ax
    pop di
    pop es
    pop bp
    ret 
	
	
	printLinestartE:
    push bp
    mov bp, sp
    push si
    push cx
    push di
    push ax
    push es

    mov ax, 0xb800
    mov es, ax  

    mov ah, 0x0E
    mov si, [bp + 8]
    mov cx, [bp + 6]
    mov di, [bp + 4]
    

nextLetterstartE: 
    mov al, [si]
    mov [es:di], ax
    add di, 2
    add si, 1
    loop nextLetterstartE

    pop es
    pop ax
    pop di
    pop cx
    pop si
    pop bp
    ret 6