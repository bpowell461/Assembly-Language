; Brad Powell
; CSC 322 Fall 2020
; Summing Arrays
; Sums three different arrays of signed integers

SECTION .data
bArray:		DB		-1,2,-3,4,-5,6
wArray:		DW		09h,0ah,0bh,0ch,0dh
dArray:		DD		-10,-20,-30,-40,-50
bArraySum:	DB		0
wArraySum:	DW		0
dArraySum:	DD		0
grandTotal:	DD		0

SECTION .text

global _main

_main:

	mov ebx, bArray
	mov ecx, 6
	xor eax,eax
	l1:
		mov eax, [ebx]
		add [bArraySum], eax		
		inc ebx
		loop l1


	mov ebx, wArray
        mov ecx, 5
	xor eax,eax
        l2:
                mov eax, [ebx]
                add [wArraySum], eax
		add ebx, 2
                loop l2


	mov ebx, dArray
        mov ecx, 5
	xor eax,eax
	l3:
		mov eax, [ebx]
		add [dArraySum], eax
		add ebx, 4
		loop l3


	xor eax,eax
	mov eax, [bArraySum]
	add eax, [wArraySum]
	add eax, [dArraySum]
	

	mov [grandTotal], eax


	lastBreak:


	mov eax, 1
	mov ebx, 0
	int 80h
