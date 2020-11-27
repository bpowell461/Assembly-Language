; Brad Powell
; CSC 322 Fall 2020
; Fibonacci Numbers
; Generates Fibonacci Numbers

SECTION .data

count: dd 14

SECTION .bss

Fibs: RESD 16

SECTION .text

global _main

_main:

	mov ecx, count

	mov esi, Fibs

	mov dword [esi+0], 0

	mov dword [esi+4], 1
	add esi, 8

	fibLoop:

		mov eax, [esi-4]
		mov ebx, [esi-8]
		add eax, ebx
		mov [esi], eax
		add esi, 4
	loop fibLoop		

	done:


	mov eax, 1
	mov ebx, 0
	int 80h
