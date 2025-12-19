global main

section .data
A dq 0
B dq 0
seeSpace dq 0

errMsg db "Error",10
errLen equ 6

section .bss
input   resb 4096
line    resb 256
output  resb 256

section .text

main:
ReadAll:
    mov rax, 0
    mov rdi, 0
    mov rsi, input
    mov rdx, 4096
    syscall
    test rax, rax
    jz Exit

    mov rbx, 0
    mov r12, rax

ParseLoop:
    cmp rbx, r12
    jge ReadAll

    mov rdi, line
LineCopy:
    mov al, [input + rbx]
    inc rbx
    cmp al, 10
    je LineDone
    mov [rdi], al
    inc rdi
    jmp LineCopy

LineDone:
    mov byte [rdi], 0

    ; exit
    cmp dword [line], 'tixe'
    je Exit

    ; div
    cmp dword [line], ' vid'
    je DivMl

    ; mul
    cmp dword [line], ' lum'
    je DivMl

    ; trim
    cmp dword [line], 'mirt'
    je Trim

    ; lower
    cmp dword [line], 'ewol'
    je lower

    jmp ParseLoop

DivMl:
    mov qword [A], 0
    mov qword [B], 0
    mov rbx, 4
    xor r12, r12
    xor r13, r13

FindB:
    movzx r15, byte [line + rbx]
    cmp r15, '-'
    jne .digit
    mov r12, 1
    inc rbx
    jmp FindB

.digit:
    cmp r15, ' '
    je FindA
    sub r15, '0'
    mov rax, [A]
    imul rax, 10
    add rax, r15
    mov [A], rax
    inc rbx
    jmp FindB

FindA:
    inc rbx
NextA:
    movzx r15, byte [line + rbx]
    cmp r15, '-'
    jne .digitA
    mov r13, 1
    inc rbx
    jmp NextA

.digitA:
    cmp r15, 0
    je ApplySigns
    sub r15, '0'
    mov rax, [B]
    imul rax, 10
    add rax, r15
    mov [B], rax
    inc rbx
    jmp NextA

ApplySigns:
    cmp r12, 1
    jne .sb
    neg qword [A]
.sb:
    cmp r13, 1
    jne Calc
    neg qword [B]

Calc:
    cmp byte [line], 'd'
    je DoDiv
    mov rax, [A]
    imul rax, [B]
    jmp PrintNumber

DoDiv:
    cmp qword [B], 0
    je PrintError
    mov rax, [A]
    cqo
    idiv qword [B]
    jmp PrintNumber

PrintError:
    mov rax, 1
    mov rdi, 1
    mov rsi, errMsg
    mov rdx, errLen
    syscall
    jmp ParseLoop

PrintNumber:
    mov rbx, 10
    lea rsi, [output+255]
    mov byte [rsi], 10
    dec rsi

    mov r8, rax
    test rax, rax
    jge .c
    neg rax

.c:
    xor rdx, rdx
    div rbx
    add dl, '0'
    mov [rsi], dl
    dec rsi
    test rax, rax
    jnz .c

    cmp r8, 0
    jge .p
    mov byte [rsi], '-'
    dec rsi

.p:
    inc rsi
    mov rdx, output+256
    sub rdx, rsi
    mov rax, 1
    mov rdi, 1
    mov rsi, rsi
    syscall
    jmp ParseLoop

Trim:
    mov rsi, line+5
    mov rdi, output
    mov byte [seeSpace], 1

.tl:
    mov al, [rsi]
    cmp al, 0
    je .td

    cmp al, ' '
    je .space
    cmp al, 9
    je .space

    mov byte [seeSpace], 0
    mov [rdi], al
    inc rdi
    inc rsi
    jmp .tl

.space:
    cmp byte [seeSpace], 1
    je .sk
    mov byte [seeSpace], 1
    mov byte [rdi], ' '
    inc rdi
.sk:
    inc rsi
    jmp .tl

.td:
    mov byte [rdi], 10
    inc rdi
    mov rdx, rdi
    sub rdx, output
    mov rax, 1
    mov rdi, 1
    mov rsi, output
    syscall
    jmp ParseLoop

lower:
    mov rsi, line+6
    mov rdi, output

.ll:
    mov al, [rsi]
    cmp al, 0
    je .ld
    cmp al, 'A'
    jb .cp
    cmp al, 'Z'
    ja .cp
    add al, 32
.cp:
    mov [rdi], al
    inc rdi
    inc rsi
    jmp .ll

.ld:
    mov byte [rdi], 10
    inc rdi
    mov rdx, rdi
    sub rdx, output
    mov rax, 1
    mov rdi, 1
    mov rsi, output
    syscall
    jmp ParseLoop

Exit:
    mov rax, 60
    xor rdi, rdi
    syscall
