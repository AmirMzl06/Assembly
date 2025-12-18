global main
extern printf
extern scanf

section .data
    ab_scanf_format: db "%lld %lld",0
    printf_format:   db "%lld %lld %lld",10,0 ; gcd x y

    A dq 0
    B dq 0
    Nloop dq 0

    x dq 1
    y dq 0
    a dq 0
    b dq 0

section .text
;--------------------------------------------------
; FindGCD_Recursive (با push، امن)
;--------------------------------------------------
FindGCD_Recursive:
    mov rax, [A]
    test rax, rax
    je .base

    mov rax, [B]
    cqo
    idiv qword [A]      ; فقط وقتی A≠0

    push qword [A]
    push qword [B]

    mov rbx, [A]
    mov [B], rbx
    mov [A], rdx

    inc qword [Nloop]

    call FindGCD_Recursive

    pop rbx
    pop rbx
    ret

.base:
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
    mov rbx, [rsp+8]

    ; اگر هر دو صفرند
    test rax, rax
    jne .ok1
    test rbx, rbx
    jne .ok1

    ; gcd(0,0) = 0
    mov rdi, printf_format
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    call printf
    jmp .exit

.ok1:
    mov [A], rax
    mov [B], rbx
    mov qword [Nloop], 0

    call FindGCD_Recursive

;--------------------------------------------------
FindAB:
    mov rax, [Nloop]
    test rax, rax
    je Print

    pop rax
    mov [b], rax
    pop rax
    mov [a], rax

    test qword [a], 0
    je Print     ; جلوگیری از div صفر

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

.exit:
    add rsp, 24
    xor eax, eax
    ret
