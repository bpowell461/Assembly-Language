LEN: EQU 6
STRUC mStruct
    .esc	RESB 2  ; space for <esc>[
    .row:	RESB 2  ; two digit number (characters)
    .semi	RESB 1  ; space for ;
    .col:	RESB 2  ; two digit number (characters)
    .H	RESB 1  ; space for the H
    .char:	RESB 1  ; space for THE character
    .size:
ENDSTRUC

%macro clrscr 0
    pusha
    mov	eax,4
    mov	ebx,1
    mov	ecx,cls
    mov	edx,4
    int	80h
    popa
%endmacro

%macro setCursor 2
    pusha
    mov	ah,%1
    mov	al,%2
    call _cursor
    popa
%endmacro

%macro Print 2
    pusha
    mov	eax,4
    mov	ebx,1
    mov	ecx,%1
    mov	edx,[%2]
    int	80h
    popa
%endmacro

%macro Sleep 1
    mov DWORD [sec],%1
    call _sleep
%endmacro
SECTION .data

	message:db 1bh,'[01;07H '
                db 1bh,'[01;08HB'
                db 1bh,'[01;09Hr'
                db 1bh,'[01;10Ha'
                db 1bh,'[01;11Hd'
                db 1bh,'[01;12H '


	star: db "*"
	starLen: dd $-star

	cls db	1bh, '[2J'

	row     db      '00'
        	db      ';'
	col     db      '00'
        	db      'H'

	pos     db      1bh, '['

	sec: dd 0,100000000
	
	counter: db 0
	rowCounter: db 0


	border:
	db "****************************************",0ah
	db "*                                      *",0ah
	db "*                                      *",0ah
	db "*                                      *",0ah
	db "*                                      *",0ah
	db "*                                      *",0ah
        db "*                                      *",0ah
        db "*                                      *",0ah
        db "*                                      *",0ah
	db "*                                      *",0ah
        db "*                                      *",0ah
        db "*                                      *",0ah
        db "*                                      *",0ah
        db "*                                      *",0ah
        db "*                                      *",0ah
        db "*                                      *",0ah
        db "*                                      *",0ah
	db "*                                      *",0ah
	db "*                                      *",0ah
	db "*                                      *",0ah
	db "****************************************",0ah
	
	borderSize:  dd $-border


SECTION .text
global _main

_main:
	;call _drawBorder
	
	clrscr
	setCursor 0,0
	;call _drawBorder
	Print border, borderSize    ;;For some reason whenever i clear the screen, the cursor moves on it's own
	setCursor 5,5
	Print star,starLen
	;top:    call    _displayMessage
        ;call    _pause
        ;call    _adjustMessage
        ;jmp     top

	call _pause	
	lastBreak:

	mov eax, 1
	mov ebx, 0
	int 80h


	_cursor:
	;;; save original to get col later
	pusha
        push    eax
	;;;;;; process row
        shr     ax,8    ;; shift row to right
        mov     bl,10
        div     bl      ;; puts ax/10 in al, remainder in ah
        add     ah,'0'
        add     al,'0'
        mov     BYTE [row],al
        mov     BYTE [row+1],ah
	;;;; process col
        pop     eax     ;; restore original parms
        and     ax,0FFh ;; erase row, leave col
        mov     bl,10
        div     bl      ;; puts ax/10 in al, remainder in ah
        add     ah,'0'
        add     al,'0'
        mov     BYTE [col],al
        mov     BYTE [col+1],ah

        ;;;;; now print the set cursor codes
        mov     eax,4
        mov     ebx,1
        mov     ecx,pos
        mov     edx,8
        int     80h
	popa
        ret


	_drawBorder:
		pusha

		clrscr
	
		mov byte [counter], 0
		mov ecx,40
		topWall:
			setCursor 0,[counter]
			Print star, starLen
			inc byte [counter]
		loop topWall
		
		mov byte [rowCounter], 0
		mov ecx,20
		leftWall:
			setCursor [rowCounter],0
			Print star, starLen
			inc byte [rowCounter]
		loop leftWall

		mov byte [counter], 0
		mov ecx,40
		botWall:
                        setCursor 20,[counter]
                        Print star, starLen
                        inc byte [counter]
                loop botWall

		mov byte [rowCounter], 0
		mov ecx, 20
		rightWall:
                        setCursor [rowCounter],40
                        Print star, starLen
                        inc byte [rowCounter]
                loop rightWall

		popa
		ret
_adjustMessage:
        pusha

        mov     al, BYTE [message + mStruct.char] ;; get first char to put at bottom
        push    eax   ; save for bottom

        mov     ebx,message  ;; pointer into array, starting at top
        mov     ecx,LEN-1    ;; loop

_amTop: mov     dl,[ebx + mStruct.size + mStruct.char]  ;; get char below
        mov     [ebx + mStruct.char],dl                 ;; put on current row

        add     ebx,mStruct.size
        loop    _amTop

        pop     eax     ;; retreive the first char
        mov     BYTE [ebx + mStruct.char],al

        popa
        ret


;;;;;;;;;;;   Function to print the array of structs of message
_displayMessage:
        pusha
        mov     ebx,message
        mov     ecx,LEN

_dmTop: push    ecx
        push    ebx
        mov     eax,4  ; system print
        mov     ecx,ebx ; points to string to print
        mov     ebx,1   ; standard out
        mov     edx,9   ; num chars to print
        int     80h

        pop     ebx
        add     ebx,mStruct.size
        pop     ecx
        loop    _dmTop
        popa
        ret


;;;;;;;;;;;;;  Function to sleep 1/20 second ;;;;;;;;;;;;;;;;;;;;;
_pause:
        pusha
        mov     eax,162
        mov     ebx,seconds
        mov     ecx,0
        int     80h
        popa
        ret

;;;;;;;;;;;;    Tricky use of ram.... put some data here for _pause to use
seconds: dd     0,50000000  ;;;  seconds, nanoseconds

