
extern printf
extern fflush

section .data

    format db "%ld",0

section .bss

section .text

    global main
main:               ; Sum of 1 to x = (x^2 + x) / 2
    mov rax,100     ; Move 100 to rax
    mov rbx,100     ; Move 100 to rbx
    mul rbx         ; Square 100
    add rax,100     ; Add 100 to that
    mov rbx,2       ; Move 2 to rbx
    div rbx         ; Divide by two to get sum
    mov rbx,rax     ; Copy sum to rbx
    mul rbx         ; Square sum
    push rax        ; Push sum into stack

    xor rbx,rbx     ; Clear rbx to hold sum
    mov rcx,1       ; Start counter at 1
loop:               ; Start sum of squares
    mov rax,rcx     ; Put current num in rax
    mul rcx         ; Square that number
    add rbx,rax     ; Add that sqaure to sum
    add rcx,1       ; Increment counter
    cmp rcx,100     ; Check if counter is above 100
    jbe loop        ; If not, continue loop
    

    pop rax         ; Pop square of sum into rax
    sub rax,rbx     ; Find the difference between the square of sum and sum of squares

    push rbp
    mov rdi,format
    mov rsi,rax
    mov rax,0
    call printf
    call fflush
    pop rbp


exit:
    mov rax,1
    mov rbx,0
    int 80h
