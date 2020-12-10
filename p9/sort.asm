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

	push nums	;Bubble Sort using C style pointer parameters
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
	
    push ebp
    mov ebp,esp
    mov edx, numslen

	.loop1:
    	mov esi,[ebp+8] ;num ptr
    	mov ecx, numslen ;number of ints

	.loop2:
    	mov eax,[esi] ;compare
    	mov ebx,[esi+1]
    	cmp al,bl ;al > bl low order bits contain num
    	jl .skip

    	mov [esi],ebx ;swap
    	mov [esi+1],eax

	.skip:
    	add esi,1 ;perform loop checks
    	dec ecx
    	cmp ecx,1
    	jg .loop2
    	dec edx
    	jg .loop1

    	mov eax,[ebp+8] ;return nums

    	mov esp,ebp
    	pop ebp

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




