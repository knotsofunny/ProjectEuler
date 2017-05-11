

extern printf		; C function to print answer
extern fflush		; C function to flush output buffer


section .data
	format db "%ld", 0	; Format for answer
section .bss

section .text

	global main

main:

	mov rax,1		; Starting numbers for fibonacci sequence
	mov rbx,1		; 
	push 0			; Push starting sum to stack

Loop:
	mov rcx,rax		; Save rax's value
	add rax,rbx		; Generate next number in sequence
	mov rbx,rcx		; Move rax's original value to rbx
	
	push rbx		; Store previous fib number in stack
	mov rcx,rax		; Store current fibonacci number in rcx

	xor rdx,rdx		; Clear rdx for division
	mov rbx,2		; Put 2 in rbx to test if even
	idiv rbx		; Divide rax by 2

	pop rbx			; Put previous fib number back in rbx

	cmp rdx,0		; Check if remainder is zero
	jne Odd			; If not, skip adding the current number to the sum

Even:
	pop rdx			; Pop sum into rdx
	add rdx,rcx		; Add current fibonacci number to sum
	push rdx		; Push new sum onto stack

Odd:
	mov rax,rcx		; Put the curret fibonacci number back in rax

	cmp rax,4000000	; Check if current number is below 4 mil
	jb Loop			; If so, continue loop



	pop rdx			; Pop total sum into rdx

	push rbp		; Set up stack frame

	mov rdi,format	; Put format for printf
	mov rsi,rdx		; Parameter for printf
	mov rax,0		; no xmm registers

	call printf		; Call printf -- puts answer in output without printing 
	call fflush		; Flush output -- causes answer to be printed

	pop rbp			; restore stack


Exit:
	mov rax,1		; Exit syscall
	mov rbx,0		; Return code 0
	int 80h
