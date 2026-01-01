global main
extern printf
extern scanf

section .data
scanf_format db "%lld %lld %lld",0
printf_format db "%lld",0,10
String db "%s",0,10

False db "FALSE",0
True db "TRUE",0

output: dq printf_format,printf_format,printf_format,printf_format,printf_format,String,String,String,String,String
TorF: dq False,True

result dq 0

a1 dq 0
a2 dq 0
id dq 0

section .bss
idArr resq 10

section .text
main:
    sub rsp, 24

    mov rdi, scanf_format
    lea rsi,[rsp] ;id 
    lea rdx ,[rsp+8] ;a1
    lea rcx,[rsp+16] ;a2
    call scanf

    mov [a1],[rsp+8]
    mov [a2],[rsp+16]
    mov [id],[rsp]

    mov r9,[rsp]
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
    mov rbx,[a2]
    mov rdx,0
    imul rax, rbx
    mov rax, rdx
    imul rax, qword[idArr+32]
    add qword[result],rax

    ;5
    mov rax,[a1]
    mov rbx,[a2]
    cmp rax, rbx
    setg al
    movzx rax, al
    imul rax, qword[idArr+40]
    add qword[result],rax

    ;6
    mov rax,[a1]
    mov rbx,[a2]
    cmp rax, rbx
    setge al
    movzx rax, al
    imul rax, qword[idArr+48]
    add qword[result],rax

    ;7
    mov rax,[a1]
    mov rbx,[a2]
    cmp rax, rbx
    setb al
    movzx rax, al
    imul rax, qword[idArr+56]
    add qword[result],rax

    ;8
    mov rax,[a1]
    mov rbx,[a2]
    cmp rax, rbx
    setbe al
    movzx rax, al
    imul rax, qword[idArr+64]
    add qword[result],rax

    ;9
    mov rax,[a1]
    add rax,[a2]
    seto al
    movzx rax, al
    imul rax, qword[idArr+72]
    add qword[result],rax

    mov rcx,[id]
    mov rdi,[output+ rcx*8]
    mov rsi,result
    call printf

    add rsp, 24
    mov rax,0
    ret
