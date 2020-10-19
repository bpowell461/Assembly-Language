; Brad Powell
; CSC 322 Fall 2020
; Fibonacci Numbers MAXIMUM
; Generates the Maximum Fibonacci Number

SECTION .data


SECTION .bss

MaxFib: RESD 1

SECTION .text

global _start

_start:
    
    mov eax, 1
    mov ebx, 0
    add eax, ebx
    
    
    computeMax:
        mov eax, ebx
        add eax, ebx
        jnc computeMax
        
    mov DWORD [MaxFib], ebx    
	lastBreak:


	mov eax, 1
	mov ebx, 0
	int 80h