global asm_main
extern printf
extern scanf

section .data
    ab_scanf_format: db "%lld %lld",0
    printf_format:   db "%lld %lld %lld",10,0   ; gcd x y

    A dq 0
    B dq 0
    isChanged dq 0
    Nloop dq 0

    x dq 0
    y dq 1
    a dq 0
    b dq 0

section .text
;--------------------------------------------------
; FindGCD_Recursive  (با push)
;--------------------------------------------------
FindGCD_Recursive:
    mov rax, [A]
    test rax, rax
    je .base

    mov rax, [B]
    cqo
    idiv qword [A]        ; rdx = B % A

    ; ذخیره A و B روی stack
    push qword [A]
    push qword [B]

    mov rbx, [A]
    mov [B], rbx
    mov [A], rdx

    inc qword [Nloop]
    call FindGCD_Recursive

    ret
.base:
    ret

;--------------------------------------------------
asm_main:
    sub rsp, 24

    ; scanf
    mov rdi, ab_scanf_format
    lea rsi, [rsp]
    lea rdx, [rsp+8]
    xor rax, rax
    call scanf

    mov rax, [rsp]
    mov rbx, [rsp+8]

    ; حالت خاص: 0 0
    test rax, rax
    jne .cont0
    test rbx, rbx
    jne .cont0

    mov rdi, printf_format
    xor rsi, rsi
    xor rdx, rdx
    xor rcx, rcx
    call printf
    jmp asm_main.exit

.cont0:
    mov [A], rax
    mov [B], rbx
    mov qword [Nloop], 0
    mov qword [isChanged], 0

    ; ---------- Change (swap مثل کد خودت) ----------
    mov rax, [A]
    cmp rax, [B]
    jle .noChange

    mov rbx, [A]
    mov rcx, [B]
    mov [A], rcx
    mov [B], rbx
    mov qword [isChanged], 1

.noChange:
    call FindGCD_Recursive

;--------------------------------------------------
; FindAB  (فرمول درست backward)
;--------------------------------------------------
FindAB:
    mov rax, [Nloop]
    cmp rax, 0
    je Chn

    pop rax
    mov [b], rax
    pop rax
    mov [a], rax

    mov rax, [b]
    cqo
    idiv qword [a]     ; rax = q

    ; new_x = old_y - q*old_x
    ; new_y = old_x
    mov r8, [x]
    mov r9, [y]

    imul r8, rax
    sub r9, r8

    mov [x], r9
    mov [y], r8

    dec qword [Nloop]
    jmp FindAB

;--------------------------------------------------
; برگرداندن swap اگر انجام شده
;--------------------------------------------------
Chn:
    cmp qword [isChanged], 1
    jne End

    mov rax, [x]
    mov rbx, [y]
    mov [x], rbx
    mov [y], rax

;--------------------------------------------------
End:
    mov rdi, printf_format
    mov rsi, [B]   ; gcd
    mov rdx, [x]
    mov rcx, [y]
    xor rax, rax
    call printf

asm_main.exit:
    add rsp, 24
    xor eax, eax
    ret
