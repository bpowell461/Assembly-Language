; Brad Powell
; CSC 322
; Matrix Manipulation
; Summing a 2D array using loops


SECTION .data

ROWS: EQU 5	; defines a constant ROWS set to 5.
COLS: EQU 7	; defines a constant COLS set to 7.

MyMatrix: dd	 1,  2,  3,  4,  5,  6,  7
	  dd	 8,  9, 10, 11, 12, 13, 14
	  dd	15, 16, 17, 18, 19, 20, 21
	  dd	22, 23, 24, 25, 26, 27, 28
	  dd	29, 30, 31, 32, 33, 34, 35

rowIndex: dd 0
colIndex: dd 0

SECTION .bss
RowSums: RESD ROWS
ColSums: RESD COLS
Sum:     RESD 1

SECTION .text
global _start
_start:
	mov ebx, MyMatrix
	mov ecx, ROWS
	mov eax, 0
	mov esi, 0
	ColLoop:
		push ecx
	
		
		mov esi, 0
		mov ecx, COLS
		RowLoop:
			mov edx, [ebx]
			add dword [RowSums+eax], edx
			add dword [ColSums+esi], edx
			add dword [Sum+0], edx
			add esi, 4
			add ebx, 4
	
			sub ecx, 1
		jnz RowLoop
		add eax, 4
		
		
		pop ecx
		sub ecx, 1
	jnz ColLoop
	
	

lastBreak:


mov eax, 1
mov ebx, 0
int 80h

