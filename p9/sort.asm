;Brad Powell
;Fall 2020
;Project 9
;Sorting an array

%macro Print 2
	pusha
        MOV EAX, 4
        MOV EBX, 1
        MOV ECX, %1
        MOV EDX, %2
        int 80h
	popa
    %endmacro

SECTION .data

hundred: db 100
ten: db 10

crlf:   db      10

message:        db      "ORIGINAL ARRAY",10
msglen: EQU     ($-message)

newMessage: db "SORTED ARRAY", 10
newMsgLen: EQU ($-newMessage)

cls: db 1bh, '[2J'

nums:	db	100, 200, 5, 10, 0, 88, 22; should work with more
numslen:	EQU	($-nums)

threedigits: db "    ", 10


SECTION .text
global _main, _clrscr, _sort, _printArray, _convert
_main:
	call _clrscr

	Print message,msglen
	call _printArray

	call _sort

	Print newMessage,newMsgLen
	call _printArray



lastBreak:

mov eax, 1
mov ebx, 0
int 80h


_clrscr:
        mov eax, 4
        mov ebx, 1
        mov ecx, cls
        mov edx, 4
        int 80h
ret

_sort: ;bubble sort does not work :/
	
	pusha

	mov ecx, 6 ;size of array-1
	outerLoop:
	push ecx	
	mov ebx, nums ;original address of nums
	mov ecx, 6 ;size of array-1
	sortLoop:			

	mov esi, ebx

	inc esi ;next element

	mov eax, [esi] ;mov to a reg
	
	mov edx, [ebx]	;mov to a reg

	cmp eax, edx ;is it less than?

	jnl _skip ;if no then jump to skip and do not swap

	mov [esi], edx  ;exchanging, could use the xchg command

	mov [ebx], eax	;this should swap but idk why it doesn't work

	_skip:

	inc ebx

	loop sortLoop
	pop ecx
	loop outerLoop
 	popa

ret

_printArray:
	pusha
	mov edx, 0
	mov ecx, 7
	;mov ecx, [numslen] for some reason this gives a segfault
	printLoop:
		mov al, [nums+edx]
		call _convert
		Print threedigits, 4
		Print crlf, 1
		inc edx
	loop printLoop
	popa
ret

_convert:
	pusha
       
	mov ebx, threedigits 
	xor ah,ah

	div byte [hundred]
	add al, '0'
	mov [ebx], al
	inc ebx
	shr ax, 8

	div byte [ten]
	add al, '0'
	mov [ebx], al


	add ah, '0'
	inc ebx
	
	mov [ebx], ah

        popa
        ret


ret




