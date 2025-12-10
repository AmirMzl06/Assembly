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
    mov rdx , qword [rsp+8] ;b
    call scanf
    
    cmp rdx,rsi
    jg Change
    
    cmp rdx,0
    je End
    
    mov rcx,rdx
    jmp FindGCD
    
Change:
    mov rcx,rsi
    mov rsi,rdx
    mov rdx,rcx
    
FindGCD:
    cmp rcx,0
    je End
    
    cqo
    idiv rcx
    mov rsi,rcx
    mov rcx, rdx
    
    jmp FindGCD
    
    
End:    
    ;mov rsi,rsi
    mov rdi,printf_format
    add rsp, 24
    mov eax, 0
    ret
