global main

section .data
A dq 0
B dq 0
counter dq 0
powTen dq 1
powTenA dq 1
trimCounter dq 5
seeSpace dq 0
lowerCounter dq 6

errMsg db "Error",10
errLen equ 6

nl db 10

section .bss
input  resb 100
output resb 100

section .text

main:
MainLoop:
    mov rax, 0
    mov rdi, 0
    mov rsi, input
    mov rdx, 100
    syscall

    cmp byte [input], 'e'
    je Exit

    cmp byte [input], 'd'
    je DivMl
    cmp byte [input], 'm'
    je DivMl
    cmp byte [input], 't'
    je Trim
    cmp byte [input], 'l'
    je lower

    jmp MainLoop

DivMl:
    mov qword [A], 0
    mov qword [B], 0
    mov rbx, 4
    xor r12, r12 

FindB:
    movzx r15, byte [input + rbx]
    
    cmp r15, '-'
    jne .checkDigit
    mov r12, 1
    inc rbx
    jmp FindB

.checkDigit:
    cmp r15, ' '
    je FindA
    cmp r15, 10
    je Calculate
    
    sub r15, '0'
    
    mov rax, [A]
    imul rax, 10
    add rax, r15
    mov [A], rax
    
    inc rbx
    jmp FindB

FindA:
    inc rbx
    xor r13, r13

NextA:
    movzx r15, byte [input + rbx]
    
    cmp r15, '-'
    jne .checkDigitA
    mov r13, 1
    inc rbx
    jmp NextA

.checkDigitA:
    cmp r15, 10
    je ApplySigns
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
    jne .signB
    neg qword [A]

.signB:
    cmp r13, 1
    jne Calculate
    neg qword [B]

Calculate:
    cmp byte [input], 'd'
    je clcD
    jmp clcM

clcD:
    cmp qword [B], 0
    je PrintError
    mov rax, [A]
    cqo
    idiv qword [B]
    jmp PrintNumber

clcM:
    mov rax, [A]
    imul rax, [B]
    jmp PrintNumber

PrintError:
    mov rax, 1
    mov rdi, 1
    mov rsi, errMsg
    mov rdx, errLen
    syscall
    jmp MainLoop

PrintNumber:
    mov rbx, 10
    lea rsi, [output + 99]
    mov byte [rsi], 10
    dec rsi

    mov r8, rax
    test rax, rax
    jge .conv
    neg rax

.conv:
    xor rdx, rdx
    div rbx
    add dl, '0'
    mov [rsi], dl
    dec rsi
    test rax, rax
    jnz .conv

    cmp r8, 0
    jge .print
    mov byte [rsi], '-'
    dec rsi

.print:
    inc rsi
    mov rdx, output+100
    sub rdx, rsi
    mov rax, 1
    mov rdi, 1
    syscall
    jmp MainLoop

Trim:
    mov rsi, input
    add rsi, 5
    mov rdi, output
    xor rcx, rcx
    mov byte [seeSpace], 0
    jmp .trimLoop

.trimLoop:
    mov al, [rsi]
    cmp al, 10
    je .done
    cmp al, 0
    je .done
    
    cmp al, ' '
    je .space
    cmp al, 9
    je .space

    mov byte [seeSpace], 0
    mov [rdi], al
    inc rdi
    inc rsi
    jmp .trimLoop

.space:
    cmp byte [seeSpace], 1
    je .skip
    
    mov byte [seeSpace], 1
    mov byte [rdi], ' '
    inc rdi
.skip:
    inc rsi
    jmp .trimLoop

.done:
    mov byte [rdi], 10
    inc rdi

    mov rdx, rdi
    sub rdx, output
    mov rax, 1
    mov rdi, 1
    mov rsi, output
    syscall

    jmp MainLoop

lower:
    mov rsi, input
    add rsi, 6
    mov rdi, output
    jmp .lowLoop

.lowLoop:
    mov al, [rsi]
    cmp al, 10
    je .lend
    cmp al, 0
    je .lend
    
    cmp al, 'A'
    jb .copy
    cmp al, 'Z'
    ja .copy
    add al, 32

.copy:
    mov [rdi], al
    inc rdi
    inc rsi
    jmp .lowLoop

.lend:
    mov byte [rdi], 10
    inc rdi

    mov rdx, rdi
    sub rdx, output
    mov rax, 1
    mov rdi, 1
    mov rsi, output
    syscall

    jmp MainLoop

Exit:
    mov rax, 60
    xor rdi, rdi
    syscall
