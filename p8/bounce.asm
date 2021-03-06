%macro Print 2
	pusha
    	MOV EAX, 4
	MOV EBX, 1
	MOV ECX, %1
	MOV EDX, %2
	int 80h
	popa
    %endmacro

%macro setCursor 2
	pusha
	mov ah, %1
        mov al, %2
	call _cursor
	popa
%endmacro

SECTION .data
message:	db	" Cheeseburger "
msglen:	EQU	($-message)

cls: db	1bh, '[2J'

row:     db      '00'
        db      ';'
col:     db      '00'
        db      'H'

pos:     db      1bh, '['

counter: db 0


sec: dd 0,100000000 

SECTION .text

global _main, _clrscr, _cursor, _sleep
_main:

	
	call _clrscr
	mov al, [counter]
	
	infinite:
		call _clrscr
		setCursor 10, al
		Print message, msglen
		inc byte al
		call _sleep
		cmp byte al, 14
		je resetCounter
	jmp infinite

	resetCounter:
		mov byte al, 0
		jmp infinite


lastBreak:


mov eax, 1
mov ebx, 0
int 80h


_clrscr:
	pusha
	mov eax, 4
	mov ebx, 1
	mov ecx, cls
	mov edx, 4
	int 80h
	popa
ret

_cursor:
        pusha
;;; save original to get col later
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




_sleep:
	pusha
   	mov eax,162
        mov ebx, sec
        mov ecx,0
        int 80h
        popa
	
ret
