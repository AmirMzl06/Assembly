global asm_main

extern printf
extern scanf

section .data
ab_scanf_format: db "%lld %lld",0
printf_format:   db "%lld %lld %lld",10,0   ; gcd x y

A dq 0
B dq 0
An dq 0
Bn dq 0
isChanged dq 0
Nloop dq 0

x  dq 1
y  dq 0
x0 dq 1
y0 dq 0
x1 dq 0
y1 dq 1

a dq 0
b dq 0

section .text
asm_main:
    sub rsp, 24

    mov rdi, ab_scanf_format
    lea rsi, [rsp]
    lea rdx, [rsp+8]
    xor rax, rax
    call scanf

    mov rax, [rsp]
    mov [A], rax    ;A kochik taras
    mov [An],rax
    mov rax, [rsp+8]
    mov [B], rax
    mov [Bn],rax
    
    mov qword [Nloop], 0
    mov qword [isChanged], 0
    mov rax,[A]
    cmp rax,[B]
    jl Change
    
    jmp Continue

Change:
    mov rax, [A]
    mov rbx, [B]
    mov [A], rbx
    mov [B], rax
    mov qword [isChanged], 1
     

Continue:
    mov rax, [A]
    cmp rax, 0
    je End
    
FindGCD:
    mov rax, [B]
    cqo
    idiv qword [A]
    
    mov rbx, [A]
    push rbx
    mov rbx, [B]
    push rbx

    mov rbx, [A]
    mov [B], rbx
    mov [A], rdx

    mov rax, [Nloop]
    inc rax
    mov [Nloop], rax

    cmp rdx, 0
    jne FindGCD
    
FindAB:
    mov rax, [Nloop]
    cmp rax, 0
    je Calculate

    pop rax
    mov [b], rax
    pop rax
    mov [a], rax

    mov rax, [a]
    cqo
    idiv qword [b]

    ; x update
    mov r9, [x1]
    imul r9, rax
    mov r10, [x0]
    sub r10, r9
    mov [x], r10

    mov r9, [x1]
    mov [x0], r9
    mov r9, [x]
    mov [x1], r9

    ; y update
    mov r9, [y1]
    imul r9, rax
    mov r10, [y0]
    sub r10, r9
    mov [y], r10

    mov r9, [y1]
    mov [y0], r9
    mov r9, [y]
    mov [y1], r9

    mov rax, [Nloop]
    dec rax
    mov [Nloop], rax
    jmp FindAB

Calculate:
    mov rax,[Bn]
    imul rax,[y]
    imul rax,-1
    add rax,[B] ;GCD
    cqo
    idiv qword [An]
    mov [x],rax

Chn:
    cmp qword [isChanged], 1
    jne Calculate

    mov rax, [x]
    mov rbx, [y]
    mov [x], rbx
    mov [y], rax
  
End:
    mov rdi, printf_format
    mov rsi, [B]    ; gcd
    mov rdx, [x]
    mov rcx, [y]
    xor rax, rax
    call printf

    add rsp, 24
    xor eax, eax
    ret
