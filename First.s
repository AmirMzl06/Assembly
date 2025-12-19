global main

section .data
A dq 0
B dq 0
seeSpace db 0

errMsg db "Error",10
errLen equ $ - errMsg

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

    mov r12, rax
    xor rbx, rbx

ParseLoop:
    cmp rbx, r12
    jge ReadAll

    mov rdi, line
    xor rcx, rcx

LineCopy:
    cmp rbx, r12
    jge LineDone
    mov al, [input + rbx]
    inc rbx
    cmp al, 10
    je LineDone
    mov [rdi + rcx], al
    inc rcx
    jmp LineCopy

LineDone:
    mov byte [rdi + rcx], 0

    cmp dword [line], 'exit'
    je Exit
    cmp byte [line + 4], 0
    jne CheckCmd
    cmp byte [line + 3], 't'
    je Exit

CheckCmd:
    mov al, [line]
    cmp al, 'd'
    je DivMl
    cmp al, 'm'
    je DivMl
    cmp al, 't'
    je Trim
    cmp al, 'l'
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
    cmp r15, 9
    je FindB
    cmp r15, 0
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
    cmp r15, ' '
    je NextA
    cmp r15, 9
    je NextA
    sub r15, '0'
    mov rax, [B]
    imul rax, 10
    add rax, r15
    mov [B], rax
    inc rbx
    jmp NextA

ApplySigns:
    test r12, r12
    jz .sb
    neg qword [A]
.sb:
    test r13, r13
    jz Calc
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
    test rdx, rdx
    jz PrintNumber
    mov rcx, [A]
    xor rcx, [B]
    jns PrintNumber
    dec rax
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
    lea rsi, [output + 255]
    mov byte [rsi], 10
    dec rsi

    mov r8, rax
    test rax, rax
    jge .loop
    neg rax

.loop:
    xor rdx, rdx
    div rbx
    add dl, '0'
    mov [rsi], dl
    dec rsi
    test rax, rax
    jnz .loop

    cmp r8, 0
    jge .print
    mov byte [rsi], '-'
    dec rsi

.print:
    inc rsi
    mov rdx, output + 256
    sub rdx, rsi
    mov rax, 1
    mov rdi, 1
    syscall
    jmp ParseLoop

Trim:
    mov rsi, line + 5
    mov rdi, output
    mov byte [seeSpace], 0

TrimLoop:
    mov al, [rsi]
    test al, al
    jz TrimEnd
    cmp al, ' '
    je TrimSpace
    cmp al, 9
    je TrimSpace
    mov byte [seeSpace], 0
    mov [rdi], al
    inc rdi
    inc rsi
    jmp TrimLoop

TrimSpace:
    cmp byte [seeSpace], 1
    je TrimSkip
    mov byte [seeSpace], 1
    cmp rdi, output
    je TrimSkip
    mov byte [rdi], ' '
    inc rdi
TrimSkip:
    inc rsi
    jmp TrimLoop

TrimEnd:
    cmp rdi, output
    je TrimNL
    cmp byte [rdi - 1], ' '
    jne TrimNL
    dec rdi
TrimNL:
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
    mov rsi, line + 6
    mov rdi, output

LowerLoop:
    mov al, [rsi]
    test al, al
    jz LowerEnd
    cmp al, 'A'
    jb LowerCopy
    cmp al, 'Z'
    ja LowerCopy
    add al, 32
LowerCopy:
    mov [rdi], al
    inc rdi
    inc rsi
    jmp LowerLoop

LowerEnd:
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
