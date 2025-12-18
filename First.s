global main
extern printf
extern scanf

section .data
    ab_scanf_format: db "%lld %lld",0
    printf_format:   db "%lld %lld %lld",10,0 ; gcd x y

    A dq 0
    B dq 0
    Nloop dq 0

    x dq 0
    y dq 1
    a dq 0
    b dq 0

section .text
;--------------------------------------------------
; FindGCD_Recursive (بدون push)
;--------------------------------------------------
FindGCD_Recursive:
    mov rax, [A]
    cmp rax, 0
    je .done

    mov rax, [B]
    cqo
    idiv qword [A]     ; rdx = B % A

    mov rbx, [A]
    mov [B], rbx
    mov [A], rdx

    inc qword [Nloop]

    call FindGCD_Recursive
.done:
    ret

;--------------------------------------------------
main:
    sub rsp, 24

    mov rdi, ab_scanf_format
    lea rsi, [rsp]
    lea rdx, [rsp+8]
    xor rax, rax
    call scanf

    mov rax, [rsp]
    mov [A], rax
    mov rax, [rsp+8]
    mov [B], rax

    mov qword [Nloop], 0
    call FindGCD_Recursive

;--------------------------------------------------
; FindAB (push/pop اینجاست)
;--------------------------------------------------
FindAB:
    mov rax, [Nloop]
    cmp rax, 0
    je Print

    mov rax, [B]
    push rax
    mov rax, [A]
    push rax

    pop rax
    mov [a], rax
    pop rax
    mov [b], rax

    mov rax, [b]
    cqo
    idiv qword [a]

    mov r9, [x]
    mov r10, [y]
    imul r9, rax
    sub r10, r9
    mov [x], r10
    mov [y], r9

    dec qword [Nloop]
    jmp FindAB

Print:
    mov rdi, printf_format
    mov rsi, [B]
    mov rdx, [x]
    mov rcx, [y]
    xor rax, rax
    call printf

    add rsp, 24
    xor eax, eax
    ret
