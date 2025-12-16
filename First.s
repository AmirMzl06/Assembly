global main
extern printf
extern scanf
section .data
ab_scanf_format: db "%lld %lld",0
printf_format: db "%lld %lld %lld",10,0 ; gcd x y
A dq 0
B dq 0
isChanged dq 0
Nloop dq 0
x dq 0
y dq 1
a dq 0
b dq 0
section .text
main:
    sub rsp, 24
    mov rdi, ab_scanf_format
    lea rsi, [rsp]
    lea rdx, [rsp+8]
    xor rax, rax
    call scanf
    mov rax, [rsp]
    mov [A], rax ;A kochik taras
    mov rax, [rsp+8]
    mov [B], rax
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
    je Chn
    pop rax
    mov [b], rax
    pop rax
    mov [a], rax
    mov rax, [b]
    cqo
    idiv qword [a]
    ; intertwined update for x and y
    mov r9, [x]    ; r9 = old x (temp)
    mov r11, r9    ; save old x for new y
    mov r10, [y]   ; r10 = old y
    imul r9, rax   ; r9 = q * old x
    sub r10, r9    ; r10 = old y - q * old x
    mov [x], r10   ; new x
    mov [y], r11   ; new y = old x
    mov rax, [Nloop]
    dec rax
    mov [Nloop], rax
    jmp FindAB
Chn:
    cmp qword [isChanged], 1
    jne End
    mov rax, [x]
    mov rbx, [y]
    mov [x], rbx
    mov [y], rax
End:
    mov rdi, printf_format
    mov rsi, [B] ; gcd
    mov rdx, [x]
    mov rcx, [y]
    xor rax, rax
    call printf
    add rsp, 24
    mov eax, 0
    ret
