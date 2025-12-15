global main

extern printf
extern scanf

section .data
ab_scanf_format: db "%lld %lld",0 ;a b
printf_format: db "%lld %lld %lld", 10, 0 ;gcd x y
A dq 0
B dq 0
isChanged dq 0
Nloop dq 0
Nloopp dq 0
x dq 1
y dq 0
x0 dq 1
y0 dq 0
x1 dq 0
y1 dq 1
counter dq 1
a dq 0
b dq 0
section .text
main:
    sub rsp, 24

    mov rdi, ab_scanf_format
    mov rsi, rsp          ; a (farz a > b)
    lea rdx, dword [rsp+8]      ; b
    xor rax, rax
    call scanf

    mov A, [rsp]         ; r8 = a A kochikas
    mov B, [rsp+8]       ; r9 = b B bozorgas

    cmp A, B
    jg Change
    cmp A, 0
    je End
    jmp FindGCD

Change:
    mov rcx, A
    mov A, B
    mov B, rcx
    mov isChanged,1
FindGCD:
    xor rdx, rdx
    
    mov rax, B
    div A
    
    push A
    push B
    
    mov B, A
    mov A, rdx

    
    add Nloop,1

    cmp B,0
    jne FindGCD

FindAB:
    cmp Nloop,0
    je Chn
    pop b
    pop a
    
    mov rax,a
    cqo
    idiv b

    ; update x
    mov r9,x1
    imul r9,rax
    mov r10,x0
    sub r10,r9
    mov x,r10
    mov r9,x1
    mov x0,r9
    mov x1,x

    ; update y
    mov r9,y1
    imul r9,rax
    mov r10,y0
    sub r10,r9
    mov y,r10
    mov r9,y1
    mov y0,r9
    mov y1,y

    dec Nloop
    jmp FindAB

Chn:
    cmp isChanged,1
    je Chng
    jump End

Chng:
    mov x0,x
    mov x,y
    mov y,x0
End:
    mov rdi, printf_format
    mov rsi, A    
    mov rdx, x
    mov rcx, y
    xor rax, rax
    call printf

    add rsp, 24
    mov eax, 0
    ret
