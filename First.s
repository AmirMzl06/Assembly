global main
extern printf
extern scanf

section .data
    n_input     db "%d", 0
    dbl_input   db "%lf", 0
    cmd_input   db "%s", 0
    output      db "%.3f ", 0
    output2     db "%.3f", 10, 0
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
    sub rsp,40
    mov rdi, n_input
    lea rsi, [n]
    xor eax, eax
    call scanf

get_number:
    mov rax, [counter]
    cmp rax, [n]
    je getCommand
    mov rdi, dbl_input
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
    je .read_one
    cmp al, 'p'
    je .read_one
    cmp al, 'z'
    je .read_one
    cmp al, 'r'
    je .read_one
    cmp al, 's'
    je .read_two
    cmp al, 'm'
    je .read_two
    cmp al, 'l'
    je .read_two
    cmp al, 'h'
    je .read_two
    cmp al, 'p'
    je .read_two

.read_one:
    mov rdi, n_input
    lea rsi, [idx1]
    xor eax, eax
    call scanf
    jmp .dispatch

.read_two:
    mov rdi, n_input
    lea rsi, [idx1]
    xor eax, eax
    call scanf
    mov rdi, n_input
    lea rsi, [idx2]
    xor eax, eax
    call scanf
    jmp .dispatch

.dispatch:
    mov al, [cmd]
    cmp al, 'n'       ; neg
    je .neg
    cmp al, 'p'       ; pow
    je .pow
    cmp al, 'z'       ; zero
    je .zero
    cmp al, 'r'       ; round
    je .round
    cmp al, 's'
    je .sort_dispatch
    cmp al, 'm'
    je .max_dispatch
    cmp al, 'l'
    je .low_dispatch
    cmp al, 'h'
    je .high
    cmp al, 'p'
    je .print
    jmp getCommand

.neg:
    mov rdx, [idx1]
    cmp rdx, [n]
    jae getCommand
    movsd xmm0, [array + rdx*8]
    movq xmm1, 0x8000000000000000
    xorpd xmm0, xmm1
    movsd [array + rdx*8], xmm0
    jmp getCommand

.pow:
    mov rdx, [idx1]
    cmp rdx, [n]
    jae getCommand
    movsd xmm0, [array + rdx*8]
    mulsd xmm0, xmm0
    movsd [array + rdx*8], xmm0
    jmp getCommand

.zero:
    mov rdx, [idx1]
    cmp rdx, [n]
    jae getCommand
    pxor xmm0, xmm0
    movsd [array + rdx*8], xmm0
    jmp getCommand

.round:
    mov rdx, [idx1]
    cmp rdx, [n]
    jae getCommand
    movsd xmm0, [array + rdx*8]
    roundsd xmm0, xmm0, 0
    movsd [array + rdx*8], xmm0
    jmp getCommand

.print:
    mov r11, [idx1]
    mov r12, [idx2]
.printLoop:
    cmp r11, r12
    jg .printNL
    movsd xmm0, [array + r11*8]
    mov rdi, output
    xor eax, eax
    call printf
    inc r11
    jmp .printLoop
.printNL:
    mov rdi, newline
    xor eax, eax
    call printf
    jmp getCommand

.sort_dispatch:
    cmp byte [cmd+4], 'a'
    je .sorta
    cmp byte [cmd+4], 'd'
    je .sortd
    jmp getCommand

.sorta:
    mov r11, [idx1]
    mov r12, [idx2]
.sorta_outer:
    cmp r11, r12
    jge getCommand
    mov r14, r11
    mov r13, r11
.sorta_inner:
    inc r13
    cmp r13, r12
    jge .sorta_swap
    movsd xmm0, [array + r13*8]
    movsd xmm1, [array + r14*8]
    ucomisd xmm1, xmm0
    jbe .sorta_inner
    mov r14, r13
    jmp .sorta_inner
.sorta_swap:
    movsd xmm0, [array + r11*8]
    movsd xmm1, [array + r14*8]
    movsd [array + r11*8], xmm1
    movsd [array + r14*8], xmm0
    inc r11
    jmp .sorta_outer

.sortd:
    mov r11, [idx1]
    mov r12, [idx2]
.sortd_outer:
    cmp r11, r12
    jge getCommand
    mov r14, r11
    mov r13, r11
.sortd_inner:
    inc r13
    cmp r13, r12
    jge .sortd_swap
    movsd xmm0, [array + r13*8]
    movsd xmm1, [array + r14*8]
    ucomisd xmm1, xmm0
    jae .sortd_inner
    mov r14, r13
    jmp .sortd_inner
.sortd_swap:
    movsd xmm0, [array + r11*8]
    movsd xmm1, [array + r14*8]
    movsd [array + r11*8], xmm1
    movsd [array + r14*8], xmm0
    inc r11
    jmp .sortd_outer

.max_dispatch:
    cmp byte [cmd+3], 'c'
    je .maxc
    jmp .max

.maxc:
    mov r11, [idx1]
    mov r12, [idx2]
    movsd xmm0, [array + r11*8]
.maxc_loop:
    inc r11
    cmp r11, r12
    jg .maxc_fill
    movsd xmm1, [array + r11*8]
    ucomisd xmm0, xmm1
    jae .maxc_loop
    movsd xmm0, xmm1
    jmp .maxc_loop
.maxc_fill:
    mov r11, [idx1]
.maxc_fill_loop:
    cmp r11, [idx2]
    jg getCommand
    movsd [array + r11*8], xmm0
    inc r11
    jmp .maxc_fill_loop

.lowa:
    mov r11, [idx1]
    mov r12, [idx2]
    movsd xmm0, [array + r11*8]
    movsd xmm1, xmm0
    andpd xmm1, [abs_mask]
.lowa_loop:
    inc r11
    cmp r11, r12
    jg .lowa_fill
    movsd xmm2, [array + r11*8]
    movsd xmm3, xmm2
    andpd xmm3, [abs_mask]
    ucomisd xmm1, xmm3
    jbe .lowa_loop
    movsd xmm1, xmm3
    movsd xmm0, xmm2
    jmp .lowa_loop
.lowa_fill:
    mov r11, [idx1]
.lowa_fill_loop:
    cmp r11, [idx2]
    jg getCommand
    movsd [array + r11*8], xmm0
    inc r11
    jmp .lowa_fill_loop

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
    xor eax, eax
    call printf
    jmp getCommand
