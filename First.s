global main
extern printf
extern scanf

section .data
ab_scanf_format: db "%lld %lld",0 ;a b

printf_format: db "GCD = %lld", 10, 0 ;gcd x y

section .text
main:
    sub rsp, 24

    mov rdi, ab_scanf_format
    mov rsi, rsp ;a     a > b (farz)
    lea rdx , qword [rsp+8] ;b
    xor rax, rax
    call scanf
    
    mov r8,qword [rsp] ;r8 = a
    mov r9,qword [rsp+8] ; r9 = b
    
    cmp r8,r9
    jg Change
    
    cmp r8,0
    je End
    
    jmp FindGCD
    
Change:
    mov rcx,r8
    mov r8,r9
    mov r9,rcx
    
FindGCD:
    xor rdx, rdx
    mov rax, r9
    div r8
    mov r9, r8          
    mov r8, rdx              
    cmp r8, 0
    jne End
    
    jmp FindGCD
    
    
End:    
    mov rdi,printf_format
    mov rsi,r9
    xor rax, rax
    call printf
    add rsp, 24
    mov eax, 0
    ret
