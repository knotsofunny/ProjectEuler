
extern printf
extern fflush


section .data

DIGITS dq 2, 0, 0, 0, 0, 0

section .bss

section .text

    global main

main:

    mov rdx, DIGITS     ; Store memory address of array in rdx

_loop:    

    jmp _getNumber      ; Get the current number

_gotNumber:             ; Resume loop after getting number
    push rbx            ; Store rbx on the stack

    jmp _getPowers
    add byte [rdx],1    

_exit:
    mov rax,1
    mov rbx,0
    int 80h



_getPowers:


_getNumber:
    mov rbx,[DIGITS]        ; Move ones digit into rbx 
    mov rax,[DIGITS + 8]    ; Move tens digit into rax
                            ; Increment by one quad word - eight bytes
    mov rdx,10              ; Move 10 to rdx
    mul rdx                 ; Multiply by rdx
    add rbx,rax             ; Add tens digit to rbx
    mov rax,[DIGITS + 16]   ; Repeat for all digits

    mov rdx,100
    mul rdx
    add rbx,rax
    mov rax,[DIGITS + 24]

    mov rdx,1000
    mul rdx
    add rbx,rax
    mov rax,[DIGITS + 32]

    mov rdx,10000
    mul rdx
    add rbx,rax
    mov rax,[DIGITS + 40]

    mov rdx,100000
    mul rdx
    add rbx,rax

    jmp _gotNumber              ; Resume loop

