global main
extern printf
extern scanf

section .data
n_scanf_format: db "%lld",0
scanf_format: db "%lld %lld %lld", 0
printf_format: db "%lld", 10, 0
Error_format:  db "Error", 10, 0

section .text
main:
    sub rsp, 24

    mov rdi, n_scanf_format
    mov rsi, rsp
    call scanf
    mov r12, qword [rsp]
    jmp Main_loop

Main_loop:
    cmp r12, 0
    je end
    dec r12

    mov rdi, scanf_format
    mov rsi, rsp
    lea rdx, [rsp+8]
    lea rcx, [rsp+16]
    call scanf

    mov rax, qword [rsp]
    cmp rax, 0
    je Sum
    cmp rax, 1
    je Sub
    cmp rax, 2
    je And
    cmp rax, 3
    je Or
    cmp qword [rsp], 4
    je Mul
    cmp qword [rsp], 5
    je Div
    cmp qword [rsp], 6
    je Pow

    ; اگر هیچ‌کدوم نبود -> Error
    mov rdi, Error_format
    call printf
    jmp Main_loop

Sum:
    mov rax, qword [rsp+8]
    add rax, qword [rsp+16]
    mov rsi, rax
    mov rdi, printf_format
    call printf
    jmp Main_loop


Sub:
    mov rax, qword [rsp+8]
    sub rax, qword [rsp+16]
    mov rsi, rax
    mov rdi, printf_format
    call printf
    jmp Main_loop


And:
    mov rax, qword [rsp+8]
    cmp rax, 0
    je Zero

    mov rax, qword [rsp+16]
    cmp rax, 0
    je Zero

    mov rax, 1
    mov rsi, rax
    mov rdi, printf_format
    call printf
    jmp Main_loop

Zero:
    mov rax, 0
    mov rsi, rax
    mov rdi, printf_format
    call printf
    jmp Main_loop

Or:
    mov rax, qword [rsp+8]
    cmp rax, 0
    je orZero

    mov rax, 1
    mov rsi, rax
    mov rdi, printf_format
    call printf
    jmp Main_loop

orZero:
    mov rax, qword [rsp+16]
    cmp rax, 0
    je Z
    jmp O

Z:
    mov rax, 0
    mov rsi, rax
    mov rdi, printf_format
    call printf
    jmp Main_loop

O:
    mov rax, 1
    mov rsi, rax
    mov rdi, printf_format
    call printf
    jmp Main_loop

Mul:
    mov rax, qword [rsp+8]
    imul rax, qword [rsp+16]    ; rax = rax * [rsp+16] (lower 64-bit)
    mov rsi, rax
    mov rdi, printf_format
    call printf
    jmp Main_loop

Div:
    cmp qword [rsp+16], 0
    je PrintError

    mov rax, qword [rsp+8]
    cqo
    idiv qword [rsp+16]

    cmp rdx, 0
    jne Div2

    mov rsi, rax
    mov rdi, printf_format
    call printf
    jmp Main_loop

Div2:
    mov rcx, qword [rsp+8]
    xor rcx, qword [rsp+16]
    js Div3

    mov rsi, rax
    mov rdi, printf_format
    call printf
    jmp Main_loop

Div3:
    dec rax
    mov rsi, rax
    mov rdi, printf_format
    call printf
    jmp Main_loop

PrintError:
    mov rdi, Error_format
    call printf
    jmp Main_loop

Pow:
    mov rax, 1
    mov rbx, qword [rsp+8]
    mov rcx, qword [rsp+16]
.pow_loop:
    cmp rcx, 0
    je .pow_done
    imul rax, rbx
    dec rcx
    jmp .pow_loop
.pow_done:
    mov rsi, rax
    mov rdi, printf_format
    call printf
    jmp Main_loop

end:
    add rsp, 24
    mov eax, 0
    ret
