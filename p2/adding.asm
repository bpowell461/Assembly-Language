;Brad Powell
;Project 2 Adding Integers
;09/16/20
;I like assembly!

SECTION .data
SECTION .bss
ax1: resb 2
ax2: resb 2
ax3: resb 2
ax4: resb 2
ax5: resb 2
ax6: resb 2
ax7: resb 2
ax8: resb 2
ax9: resb 2
ax10: resb 2
SECTION .text
global _main
_main:
	mov AX, 0CDBAh
	mov BX, 0CDABh
	add AX, BX
	mov [ax1], AX

	mov AX, 0ABCDh
        mov BX, 0ABCDh
        add AX, BX
	mov [ax2], AX

	mov AX, 0FAFAh
        mov BX, 00505h
        add AX, BX
        mov [ax3], AX

	mov AX, 0F0F0h
        mov BX, 0FF00h
        add AX, BX
        mov [ax4], AX

	mov AX, 0D468h
        mov BX, 02B98h
        add AX, BX
        mov [ax5], AX

	mov AX, 0700Fh
        mov BX, 00FF1h
        add AX, BX
        mov [ax6], AX

	mov AX, 01234h
        mov BX, 07654h
        add AX, BX
        mov [ax7], AX

	mov AX, 00B0Bh
        mov BX, 0A11Eh
        add AX, BX
        mov [ax8], AX

	mov AX, 07654h
        mov BX, 0789Ah
        add AX, BX
        mov [ax9], AX

	mov AX, 08000h
        mov BX, 08000h
        add AX, BX
        mov [ax10], AX

	mov ebx,0
	mov eax,1
	int 80h
