
extern printf		;printf from C
extern fflush

section .data

	ans db "%ld", 0	;Format for answer
	flush db "", 10
section .bss

section .text

	global main

main:

	nop
	xor eax,eax		;clear eax to store answer
	xor ebx,ebx 	;clear ebx to store counter

Three: 
	add ebx,3		;Add 3 to ebx, going through all multiples of 3
	add eax,ebx 	;Add each multiple of 3 to eax

	cmp ebx,1000-3	;If ebx has reached highest value
	jb Three		;Jump back to Three
	
	xor ebx,ebx		;Clear ebx to restart counter

Five:
	add ebx,5		;Same as above block
	add eax,ebx

	cmp ebx,1000-5
	jb Five

	xor ebx,ebx

Fifteen:
	add ebx,15
	sub eax,ebx		;All multiples of 15 are subtracted out

	cmp ebx,1000-15
	jb Fifteen


	push rbp		;set up stack frame
	
	mov rdi,ans		;put format for printf
	mov rsi,rax		;parameter for printf
	mov rax,0		;no xmm registers
	call printf		;call C function

	call fflush		;flush standard output
					;allows printf to print without a newline

	pop rbp			;restore stack

Exit:
	mov eax,1
	mov ebx,0
	int 80h



