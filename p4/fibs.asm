; Brad Powell
; CSC 322 Fall 2020
; Fibonacci Numbers
; Generates Fibonacci Numbers

SECTION .data

count DWORD 14

SECTION .bss

Fibs: RESD 16

SECTION .text

global _main

_main:

	mov ecx, count

	mov esi, Fibs

	mov [esi+0], 0h

	mov [esi+4], 1h
	add esi, 8

	fibLoop:

		mov eax, [esi-4]
		mov ebx, [esi-8]
		add eax, ebx
		move [esi], eax
		add esi, 4
	loop fibLoop		

	done:


	mov eax, 1
	mov ebx, 0
	int 80h
