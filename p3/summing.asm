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

	mov ebx, [bArray]
	mov eax, 0
	mov ecx, 5

	l1:
		add eax, ebx
		add ebx, 1
		add ecx, eax
		loop l1
	
	
	mov [bArraySum], ecx


	mov ebx, [wArray]
        mov eax, 0
        mov ecx, 5

        l2:
                add eax, ebx
                add ebx, 2
                add ecx, eax
                loop l2

        mov [wArraySum], ecx


	mov ebx, [dArray]
        mov eax, 0
        mov ecx, 5

	l3:
		add eax, ebx
		add ebx, 4
		add ecx, eax
		loop l3

	mov dword [dArraySum], ecx

	

	mov ecx, [bArraySum]
	add ecx, [wArraySum]
	add ecx, [dArraySum]
	

	mov [grandTotal], ecx


	lastBreak:


	mov eax, 1
	mov ebx, 0
	int 80h
