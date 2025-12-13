global main

extern printf
extern scanf

section .data
ab_scanf_format: db "%lld %lld",0 ;a b
printf_format: db "%lld %lld %lld", 10, 0 ;gcd x y

section .text
main:
    sub rsp, 24

    mov rdi, ab_scanf_format
    mov rsi, rsp          ; a (farz a > b)
    lea rdx, dword [rsp+8]      ; b
    xor rax, rax
    call scanf

    mov r8, [rsp]         ; r8 = a
    mov r9, [rsp+8]       ; r9 = b
    mov r10,0 ;tedad tekrar shodan loop
    mov r11,1 ;x
    mov r12,0 ;y
    mov r13,1 ;x0
    mov r14,0 ;y0
    mov r15,0 ;x1
    mov rdi,1 ;y1

    cmp r8, r9
    jg Change
    cmp r8, 0
    je End
    jmp FindGCD

Change:
    mov rcx, r8
    mov r8, r9
    mov r9, rcx

FindGCD:
    sub rsp,16 ; baraye zakhireye 
    xor rdx, rdx
    mov [rsp+8],r9
    mov [rsp],r8
    
    mov rax, r9
    div r8
    
    mov r9, r8
    mov r8, rdx
    
    cmp r8, 0
    jne FindXY
    
    inc r10
    mov rbp,r10
    jmp FindGCD
    
FindAB:
    mov r13,r11 ;save x ghabli

    shl r14,4  ;r14 = r14*16
    add r14,24
    ;a
    mov r8 ,dword [rsp + r14 -8]
    ;b
    mov r9 , dword[rsp+r14-16]
    
    mov rax,r8
    idiv r9
    ;rax javab taghsim
    
    ;X's
    mov rsi,rax
    imul rsi,r15
    imul rsi,-1
    add rsi,r13
    mov r11,rsi
    mov r13,r15
    mov r15,r11
    
    ;Y's
    imul rax,rdi
    imul rax,-1
    add rax,r14
    mov r12,rax
    mov r14,rdi
    mov rdi,rax
    
    inc r10
    

End:
    mov rdi, printf_format
    mov rsi, r9
    mov rdx,r11
    mov rcx,r12
    xor rax, rax
    call printf

    mov rax, rbp
    inc rax
    shl rax,4
    add rax, 24
    add rsp, rax
    mov eax, 0
    ret
