global asm_main
extern printf
extern scanf

section .data
scanf_format db "%lld %lld %lld",0
printf_format db "%lld",10,0
String db "%s",10,0

False db "FALSE",0
True db "TRUE",0

output: dq printf_format,printf_format,printf_format,printf_format,printf_format,String,String,String,String,String

result dq 0
a1 dq 0
a2 dq 0
id dq 0

section .bss
idArr resq 10

section .text
asm_main:
    sub rsp, 24

    mov rdi, scanf_format
    lea rsi,[rsp]    ;id 
    lea rdx ,[rsp+8]  ;a1
    lea rcx,[rsp+16] ;a2
    xor al, al
    call scanf

    mov rax, [rsp]
    mov [id], rax
    mov rax, [rsp+8]
    mov [a1], rax
    mov rax, [rsp+16]
    mov [a2], rax

    mov r9, [id]
    mov qword [idArr + r9*8], 1

    ;0
    mov rax,[a1]
    or rax,[a2]
    imul rax, qword[idArr+0]
    add qword[result],rax

    ;1
    mov rax,[a1]
    and rax,[a2]
    imul rax, qword[idArr+8]
    add qword[result],rax

    ;2
    mov rax,[a1]
    add rax,[a2]
    imul rax, qword[idArr+16]
    add qword[result],rax

    ;3
    mov rax,[a1]
    imul rax,[a2]
    imul rax, qword[idArr+24]
    add qword[result],rax

    ;4
    mov rax,[a1]
    imul qword[a2]
    mov rax, rdx
    imul rax, qword[idArr+32]
    add qword[result],rax

    ;5
    mov rax,[a1]
    cmp rax, [a2]
    setg al
    movzx rax, al
    mov rbx, True
    sub rbx, False
    imul rax, rbx
    add rax, False
    imul rax, qword[idArr+40]
    add qword[result],rax

    ;6
    mov rax,[a1]
    cmp rax, [a2]
    setge al
    movzx rax, al
    mov rbx, True
    sub rbx, False
    imul rax, rbx
    add rax, False
    imul rax, qword[idArr+48]
    add qword[result],rax

    ;7
    mov rax,[a1]
    cmp rax, [a2]
    setb al
    movzx rax, al
    mov rbx, True
    sub rbx, False
    imul rax, rbx
    add rax, False
    imul rax, qword[idArr+56]
    add qword[result],rax

    ;8
    mov rax,[a1]
    cmp rax, [a2]
    setbe al
    movzx rax, al
    mov rbx, True
    sub rbx, False
    imul rax, rbx
    add rax, False
    imul rax, qword[idArr+64]
    add qword[result],rax

    ;9
    mov rax,[a1]
    add rax,[a2]
    seto al
    movzx rax, al
    mov rbx, True
    sub rbx, False
    imul rax, rbx
    add rax, False
    imul rax, qword[idArr+72]
    add qword[result],rax

    mov rcx,[id]
    mov rdi,[output + rcx*8]
    mov rsi,[result]
    mov al, 0
    call printf

    add rsp, 24
    mov rax,0
    ret
