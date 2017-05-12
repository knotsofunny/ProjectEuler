extern printf
extern fflush

section .data

	format db "%ld",0		; Format for answer

section .bss

section .text

	global main
main:
	mov rax,600851475143	; Initial value
	mov rbx,rax				; Store initial value
	mov rcx,1				; Start counter

_loop:
	add rcx,1				; Increment counter

	cmp rcx,rax				; Test if counter equals rax
	je _exit				; If so, exit

	xor rdx,rdx				; Clear rdx
	div rcx					; Divide rax by counter

	cmp rdx,0				; Test if there was a remainder
	je _remain				; If so, jump to _remain
							; If no remainder	
	mov rax,rbx				; Restore rax
	jmp _loop				; Repeat loop

_remain:
	mov rcx,1				; Reset counter
	mov rbx,rax				; Store new rax
	jmp _loop				; Repeat loop


_exit:

	push rbp				; Set up stack frame
	mov rdi,format			; Format for printf
	mov rsi,rax				; Parameter for printf
	mov rax,0				; No xmm registers
	call printf				; Call printf
	call fflush				; Flush output, actually printing answer
	pop rbp					; Restore stack

	mov rax,1				
	mov rbx,0
	int 80h

