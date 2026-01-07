global main
extern printf
extern scanf

section .data
    n_input     db "%d", 0
    input       db "%lf", 0
    cmd_input   db "%s", 0

    output      db "%.3lf ", 0
    output2     db "%.3lf", 10, 0
    newline     db 10, 0

    abs_mask    dq 0x7FFFFFFFFFFFFFFF

    n           dq 0
    counter     dq 0

section .bss
    array       resq 100
    cmd         resb 16
    idx1        resq 1
    idx2        resq 1

section .text
main:
    sub rsp, 40

    mov rdi, n_input
    lea rsi, [n]
    xor eax, eax
    call scanf

get_number:
    mov rax, [counter]
    cmp rax, [n]
    je getCommand

    mov rdi, input
    lea rsi, [array + rax*8]
    xor eax, eax
    call scanf

    inc qword [counter]
    jmp get_number


getCommand:
    mov rdi, cmd_input
    lea rsi, [cmd]
    xor eax, eax
    call scanf

    mov al, [cmd]

    cmp al, 'e'
    je .exit

    cmp al, 'n'
    je .neg

    cmp al, 'p'
    je .pow_or_print

    cmp al, 'z'
    je .zero

    cmp al, 'r'
    je .round

    cmp al, 's'
    je .sort

    cmp al, 'm'
    je .max_group

    cmp al, 'l'
    je .low_group

    cmp al, 'h'
    je .high

    jmp getCommand


.read_one:
    mov rdi, n_input
    lea rsi, [idx1]
    xor eax, eax
    call scanf
    ret

.read_two:
    mov rdi, n_input
    lea rsi, [idx1]
    xor eax, eax
    call scanf

    mov rdi, n_input
    lea rsi, [idx2]
    xor eax, eax
    call scanf
    ret


.pow_or_print:
    mov al, [cmd+1]
    cmp al, 'o'
    je .pow
    cmp al, 'r'
    je .print
    jmp getCommand

.sort:
    call .read_two
    mov al, [cmd+4]
    cmp al, 'a'
    je .sorta
    cmp al, 'd'
    je .sortd
    jmp getCommand

.max_group:
    call .read_two
    mov al, [cmd+1]
    cmp al, 'a'
    je .max_or_maxc
    cmp al, 'i'
    je .min
    jmp getCommand

.max_or_maxc:
    mov al, [cmd+3]
    cmp al, 'c'
    je .maxc
    jmp .max

.low_group:
    call .read_two
    mov al, [cmd+3]
    cmp al, 'a'
    je .lowa
    jmp .low


.exit:
    add rsp, 40
    xor eax, eax
    ret

.neg:
    call .read_one
    mov rdx, [idx1]
    movsd xmm0, [array + rdx*8]
    movq xmm1, 0x8000000000000000
    xorpd xmm0, xmm1
    movsd [array + rdx*8], xmm0
    jmp getCommand

.pow:
    call .read_one
    mov rdx, [idx1]
    movsd xmm0, [array + rdx*8]
    mulsd xmm0, xmm0
    movsd [array + rdx*8], xmm0
    jmp getCommand

.zero:
    call .read_one
    mov rdx, [idx1]
    pxor xmm0, xmm0
    movsd [array + rdx*8], xmm0
    jmp getCommand

.round:
    call .read_one
    mov rdx, [idx1]
    movsd xmm0, [array + rdx*8]
    roundsd xmm0, xmm0, 0
    movsd [array + rdx*8], xmm0
    jmp getCommand

.sorta:
    mov r11, [idx1]
    mov r12, [idx2]
.outerA:
    cmp r11, r12
    jge getCommand
    mov r14, r11
    mov r13, r11
.innerA:
    inc r13
    cmp r13, r12
    jge .swapA
    movsd xmm0, [array + r13*8]
    movsd xmm1, [array + r14*8]
    ucomisd xmm1, xmm0
    jbe .innerA
    mov r14, r13
    jmp .innerA
.swapA:
    movsd xmm0, [array + r11*8]
    movsd xmm1, [array + r14*8]
    movsd [array + r11*8], xmm1
    movsd [array + r14*8], xmm0
    inc r11
    jmp .outerA

.sortd:
    mov r11, [idx1]
    mov r12, [idx2]
.outerD:
    cmp r11, r12
    jge getCommand
    mov r14, r11
    mov r13, r11
.innerD:
    inc r13
    cmp r13, r12
    jge .swapD
    movsd xmm0, [array + r13*8]
    movsd xmm1, [array + r14*8]
    ucomisd xmm1, xmm0
    jae .innerD
    mov r14, r13
    jmp .innerD
.swapD:
    movsd xmm0, [array + r11*8]
    movsd xmm1, [array + r14*8]
    movsd [array + r11*8], xmm1
    movsd [array + r14*8], xmm0
    inc r11
    jmp .outerD

.maxc:
    mov r11, [idx1]
    mov r12, [idx2]
    movsd xmm0, [array + r11*8]
.findMax:
    inc r11
    cmp r11, r12
    jg .fillMax
    movsd xmm1, [array + r11*8]
    ucomisd xmm0, xmm1
    jae .findMax
    movsd xmm0, xmm1
    jmp .findMax
.fillMax:
    mov r11, [idx1]
.fillLoop:
    cmp r11, r12
    jg getCommand
    movsd [array + r11*8], xmm0
    inc r11
    jmp .fillLoop

.lowa:
    mov r11, [idx1]
    mov r12, [idx2]
    movsd xmm0, [array + r11*8]
    movsd xmm1, xmm0
    andpd xmm1, [abs_mask]
.findLow:
    inc r11
    cmp r11, r12
    jg .fillLow
    movsd xmm2, [array + r11*8]
    movsd xmm3, xmm2
    andpd xmm3, [abs_mask]
    ucomisd xmm1, xmm3
    jbe .findLow
    movsd xmm1, xmm3
    movsd xmm0, xmm2
    jmp .findLow
.fillLow:
    mov r11, [idx1]
.fillLoop2:
    cmp r11, r12
    jg getCommand
    movsd [array + r11*8], xmm0
    inc r11
    jmp .fillLoop2

.print:
    call .read_two
    mov r11, [idx1]
    mov r12, [idx2]
.printLoop:
    cmp r11, r12
    jg .nl
    movsd xmm0, [array + r11*8]
    mov rdi, output
    mov eax, 1
    call printf
    inc r11
    jmp .printLoop
.nl:
    mov rdi, newline
    xor eax, eax
    call printf
    jmp getCommand

.max:
    mov r11, [idx1]
    mov r12, [idx2]
    movsd xmm0, [array + r11*8]
.max_loop:
    inc r11
    cmp r11, r12
    jg .print_val
    movsd xmm1, [array + r11*8]
    ucomisd xmm0, xmm1
    jae .max_loop
    movsd xmm0, xmm1
    jmp .max_loop

.min:
    mov r11, [idx1]
    mov r12, [idx2]
    movsd xmm0, [array + r11*8]
.min_loop:
    inc r11
    cmp r11, r12
    jg .print_val
    movsd xmm1, [array + r11*8]
    ucomisd xmm0, xmm1
    jbe .min_loop
    movsd xmm0, xmm1
    jmp .min_loop

.low:
    mov r11, [idx1]
    mov r12, [idx2]
    movsd xmm0, [array + r11*8]
    movsd xmm1, xmm0
    andpd xmm1, [abs_mask]
.low_loop:
    inc r11
    cmp r11, r12
    jg .print_val
    movsd xmm2, [array + r11*8]
    movsd xmm3, xmm2
    andpd xmm3, [abs_mask]
    ucomisd xmm1, xmm3
    jbe .low_loop
    movsd xmm1, xmm3
    movsd xmm0, xmm2
    jmp .low_loop

.high:
    mov r11, [idx1]
    mov r12, [idx2]
    movsd xmm0, [array + r11*8]
    movsd xmm1, xmm0
    andpd xmm1, [abs_mask]
.high_loop:
    inc r11
    cmp r11, r12
    jg .print_val
    movsd xmm2, [array + r11*8]
    movsd xmm3, xmm2
    andpd xmm3, [abs_mask]
    ucomisd xmm1, xmm3
    jae .high_loop
    movsd xmm1, xmm3
    movsd xmm0, xmm2
    jmp .high_loop

.print_val:
    mov rdi, output2
    mov eax, 1
    call printf
    jmp getCommand
