; Brad Powell
; CSC 322 Fall 2020
; Fibonacci Numbers MAXIMUM
; Generates the Maximum Fibonacci Number

SECTION .data


SECTION .bss

MaxFib: RESD 1 ;If I am correct, this should hold up to Fib(47)

SECTION .text

global _start

_start:
    
    mov eax, 1
    mov edx, 0
    add eax, edx
    mov edx, eax

    computeMax:
	push eax
        add eax, edx
	jc lastBreak
	pop edx
        jnc computeMax ;This should compute Fibonacci(46) = 1836311903


    lastBreak:
	pop edx ;Fib(47) is in the Stack so we are popping it
	mov DWORD [MaxFib+0], edx


	mov eax, 1
	mov ebx, 0
	int 80h
