global main
extern printf
extern scanf

section .data
ab_scanf_format: db "%lld %lld",0
printf_format:   db "%lld %lld %lld",10,0
A dq 0
B dq 0
isChanged dq 0
x dq 0
y dq 1

section .text

ExtGCD:
    push r12
    push r13

    mov rax, [A]
    test rax, rax
    je  .base_case

    mov rax, [B]
    cqo
    idiv qword [A]

    mov r12, rax
    mov r13, [A]

    mov [B], r13
    mov [A], rdx

    call ExtGCD

    mov r13, [x]
    imul r13, r12
    mov rdx, [y]
    sub rdx, r13

    mov r13, [x]
    mov [x], rdx
    mov [y], r13

    pop r13
    pop r12
    ret

.base_case:
    mov qword [x], 0
    mov qword [y], 1
    pop r13
    pop r12
    ret

main:
    sub rsp, 24

    mov rdi, ab_scanf_format
    lea rsi, [rsp]
    lea rdx, [rsp+8]
    xor rax, rax
    call scanf

    mov rax, [rsp]
    mov rbx, [rsp+8]

    mov [A], rax
    mov [B], rbx
    mov qword [isChanged], 0

    mov rax, [A]
    cmp rax, [B]
    jg .do_swap
    jmp .call_ext

.do_swap:
    mov rax, [A]
    mov rbx, [B]
    mov [A], rbx
    mov [B], rax
    mov qword [isChanged], 1

.call_ext:
    call ExtGCD

    cmp qword [isChanged], 1
    jne .print

    mov rax, [x]
    mov rbx, [y]
    mov [x], rbx
    mov [y], rax

.print:
    mov rdi, printf_format
    mov rsi, [B]
    mov rdx, [x]
    mov rcx, [y]
    xor rax, rax
    call printf

    add rsp, 24
    xor eax, eax
    ret
