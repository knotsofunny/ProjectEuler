
extern printf
extern fflush


section .data

format db "%ld",0
format2 db "%ld",10,0
DIGITS dq 2, 0, 0, 0, 0, 0

section .bss

section .text

    global main

main:

    push 0                  ; Push starting sum to stack

_loop:    

    jmp _getNumber          ; Get the current number on rbx
_gotNumber:                 ; Resume loop after getting number
    

    cmp rbx,200000          ; Stop after 300,000
    ja _exit

    push rbx                ; Store number on the stack

    jmp _getPowers
_gotPowers:

    pop rbx                 ; Pop number into rbx
    cmp rbx,rcx             ; Check if number and sum of digit powers are equal
    jne _skip               ; If not equal, skip adding number to sum

    pop rax                 ; Pop sum into rax
    add rax,rbx             ; Add current number
    push rax                ; Push new sum back onto stack

_skip:

    add qword [DIGITS],1        ; Add one to ones digit
    cmp qword [DIGITS],10       ; If below 10
    jb _loop                    ; Continue loop

    mov qword [DIGITS],0        ; Otherwise, set ones place to zero
    add qword [DIGITS + 8],1    ; Increment tens place
    cmp qword [DIGITS + 8],10   ; Check if tens place is less than 10
    jb _loop                    ; If so, continue loop

    mov qword [DIGITS + 8],0    ; So on and so forth for all digits
    add qword [DIGITS + 16],1
    cmp qword [DIGITS + 16],10
    jb _loop

    mov qword [DIGITS + 16],0
    add qword [DIGITS + 24],1
    cmp qword [DIGITS + 24],10
    jb _loop

    mov qword [DIGITS + 24],0
    add qword [DIGITS + 32],1
    cmp qword [DIGITS + 32],10
    jb _loop

    mov qword [DIGITS + 32],0
    add qword [DIGITS + 40],1
    jmp _loop


_exit:

    pop rax         ; Pop sum into rax
    
    push rbp
    mov rdi,format
    mov rsi,rax
    mov rax,0
    call printf     
    call fflush
    pop rbp

    mov rax,1       ; Exit normally
    mov rbx,0
    int 80h



_getPowers:
    xor rcx,rcx             ; Counter for loop
    push 0                  ; Push initial sum
_powLoop:
    mov rbx,[DIGITS+rcx]    ; Move current digit into rbx
    mov rax,rbx
    mul rbx                 ; digit^2
    mul rbx                 ; digit^3
    mul rbx                 ; digit^4
    mul rbx                 ; digit^5

    pop rbx                 ; Pop sum into rbx
    add rbx,rax             ; Add digit^5 to sum
    push rbx                ; Push new sum into stack
    add rcx,8               ; Increment counter by on quad word
    cmp rcx,40              ; Stop counter after 6 loops
    jbe _powLoop
    pop rcx                 ; Pop sum into rcx
    jmp _gotPowers          ; Resume main loop

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

