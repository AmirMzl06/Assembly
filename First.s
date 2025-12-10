global main
extern printf
extern scanf

section .data
    scan_fmt: db "%lld %lld", 0 
    print_fmt: db "GCD = %lld", 10, 0

section .text
main:
    sub rsp, 24

    mov rdi, scan_fmt
    lea rsi, [rsp] 
    lea rdx, [rsp+8]
    xor eax, eax
    call scanf


GCD_Loop:
    cmp qword [rsp+8], 0
    je End_Print

    mov rax, [rsp]
    
    cqo
    
    idiv qword [rsp+8] 

    mov rcx, [rsp+8]
    mov [rsp], rcx

    mov [rsp+8], rdx

    jmp GCD_Loop

End_Print:
    mov rdi, print_fmt
    mov rsi, [rsp]
    xor eax, eax
    call printf
    add rsp, 24
    xor eax, eax
    ret
