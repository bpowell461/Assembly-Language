; Brad Powell
; CSC 322
; Matrix Manipulation
; Summing a 2D array using loops


SECTION .data

ROWS: EQU 5	; defines a constant ROWS set to 5.
COLS: EQU 7	; defines a constant COLS set to 6.

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
global _main
_main:

MOV ecx, 0
MOV ebx, ROWS

RowLoop:
	mov  ebx, COLS


ColLoop:
	mov ecx, [colIndex]
	mov eax, [MyMatrix+ecx]
	add [RowSums], eax





	add ecx, [rowIndex]
	mov eax, [MyMatrix+ecx]
	add [ColSums], eax


	add DWORD [rowIndex], COLS*4





	add DWORD [colIndex], 4



	loop ColLoop
 
	loop RowLoop
mov eax, RowSums
add eax, ColSums
mov [Sum], eax

lastBreak: ;last label

mov eax, 1
mov ebx, 0
int 80h

