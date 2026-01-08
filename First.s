global main
extern printf, scanf, strcmp

section .data
    n_input     db "%d", 0
    input       db "%lf", 0
    cmd_input   db "%s", 0

    exit_str    db "exit", 0
    neg_str     db "neg", 0
    pow_str     db "pow", 0
    zero_str    db "zero", 0
    round_str   db "round", 0
    sorta_str   db "sorta", 0
    sortd_str   db "sortd", 0
    maxc_str    db "maxc", 0
    lowa_str    db "lowa", 0
    print_str   db "print", 0
    max_str     db "max", 0
    min_str     db "min", 0
    low_str     db "low", 0
    high_str    db "high", 0

    output      db "%.3f ", 0
    output2     db "%.3f", 10, 0
    newline     db 10, 0

    abs_mask    dq 0x7FFFFFFFFFFFFFFF,0x7FFFFFFFFFFFFFFF
    neg_mask    dq 0x8000000000000000

section .bss
    n           resq 1
    array       resq 100
    cmd         resb 16
    idx1        resq 1
    idx2        resq 1

section .text
main:
    push rbx

    mov rdi, n_input
    mov rsi, n
    xor eax, eax
    call scanf

    mov rcx, [n]
    mov rdi, array
.get_number_loop:
    push rcx
    push rdi
    mov rsi, rdi
    mov rdi, input
    xor eax, eax
    call scanf
    pop rdi
    pop rcx
    add rdi, 8
    loop .get_number_loop

.get_command:
    mov rdi, cmd_input
    mov rsi, cmd
    xor eax, eax
    call scanf

    mov rdi, cmd

    mov rsi, exit_str
    call strcmp
    test rax, rax
    jz .do_exit

    mov rsi, neg_str
    call strcmp
    test rax, rax
    jz .read_one_and_dispatch

    mov rsi, pow_str
    call strcmp
    test rax, rax
    jz .read_one_and_dispatch

    mov rsi, zero_str
    call strcmp
    test rax, rax
    jz .read_one_and_dispatch

    mov rsi, round_str
    call strcmp
    test rax, rax
    jz .read_one_and_dispatch

.read_two_and_dispatch:
    mov rdi, n_input
    mov rsi, idx1
    xor eax, eax
    call scanf

    mov rdi, n_input
    mov rsi, idx2
    xor eax, eax
    call scanf
    jmp .dispatch

.read_one_and_dispatch:
    mov rdi, n_input
    mov rsi, idx1
    xor eax, eax
    call scanf

.dispatch:
    mov rdi, cmd

    mov rsi, neg_str
    call strcmp
    test rax, rax
    jz .do_neg

    mov rsi, pow_str
    call strcmp
    test rax, rax
    jz .do_pow

    mov rsi, zero_str
    call strcmp
    test rax, rax
    jz .do_zero

    mov rsi, round_str
    call strcmp
    test rax, rax
    jz .do_round

    mov rsi, sorta_str
    call strcmp
    test rax, rax
    jz .do_sorta

    mov rsi, sortd_str
    call strcmp
    test rax, rax
    jz .do_sortd

    mov rsi, maxc_str
    call strcmp
    test rax, rax
    jz .do_maxc

    mov rsi, lowa_str
    call strcmp
    test rax, rax
    jz .do_lowa

    mov rsi, print_str
    call strcmp
    test rax, rax
    jz .do_print

    mov rsi, max_str
    call strcmp
    test rax, rax
    jz .do_max

    mov rsi, min_str
    call strcmp
    test rax, rax
    jz .do_min

    mov rsi, low_str
    call strcmp
    test rax, rax
    jz .do_low

    mov rsi, high_str
    call strcmp
    test rax, rax
    jz .do_high

    jmp .get_command

.do_exit:
    pop rbx
    xor eax, eax
    ret

.do_neg:
    mov rdx, [idx1]
    movsd xmm0, [array + rdx*8]
    movq xmm1, [neg_mask]
    xorpd xmm0, xmm1
    movsd [array + rdx*8], xmm0
    jmp .get_command

.do_pow:
    mov rdx, [idx1]
    movsd xmm0, [array + rdx*8]
    mulsd xmm0, xmm0
    movsd [array + rdx*8], xmm0
    jmp .get_command

.do_zero:
    mov rdx, [idx1]
    pxor xmm0, xmm0
    movsd [array + rdx*8], xmm0
    jmp .get_command

.do_round:
    mov rdx, [idx1]
    movsd xmm0, [array + rdx*8]
    roundsd xmm0, xmm0, 0
    movsd [array + rdx*8], xmm0
    jmp .get_command

.do_lowa:
    mov r11, [idx1]
    mov r12, [idx2]
    movsd xmm0, [array + r11*8]
    movsd xmm1, xmm0
    andupd xmm1, [abs_mask]
.findLowa:
    inc r11
    cmp r11, r12
    jg .fillLowa
    movsd xmm2, [array + r11*8]
    movsd xmm3, xmm2
    andupd xmm3, [abs_mask]
    ucomisd xmm1, xmm3
    jbe .findLowa
    movsd xmm1, xmm3
    movsd xmm0, xmm2
    jmp .findLowa
.fillLowa:
    mov r11, [idx1]
.fillLoopLowa:
    mov r12, [idx2]
    cmp r11, r12
    jg .get_command
    movsd [array + r11*8], xmm0
    inc r11
    jmp .fillLoopLowa

.do_low:
    mov r11, [idx1]
    mov r12, [idx2]
    movsd xmm0, [array + r11*8]
    movsd xmm1, xmm0
    andupd xmm1, [abs_mask]
.low_loop:
    inc r11
    cmp r11, r12
    jg .print_val
    movsd xmm2, [array + r11*8]
    movsd xmm3, xmm2
    andupd xmm3, [abs_mask]
    ucomisd xmm1, xmm3
    jbe .low_loop
    movsd xmm1, xmm3
    movsd xmm0, xmm2
    jmp .low_loop

.do_high:
    mov r11, [idx1]
    mov r12, [idx2]
    movsd xmm0, [array + r11*8]
    movsd xmm1, xmm0
    andupd xmm1, [abs_mask]
.high_loop:
    inc r11
    cmp r11, r12
    jg .print_val
    movsd xmm2, [array + r11*8]
    movsd xmm3, xmm2
    andupd xmm3, [abs_mask]
    ucomisd xmm1, xmm3
    jae .high_loop
    movsd xmm1, xmm3
    movsd xmm0, xmm2
    jmp .high_loop

.print_val:
    mov rdi, output2
    mov eax, 1
    call printf
    jmp .get_command

.do_print:
    mov rbx, [idx1]
    mov r12, [idx2]
.print_loop:
    cmp rbx, r12
    jg .print_newline
    movsd xmm0, [array + rbx*8]
    mov rdi, output
    mov eax, 1
    call printf
    inc rbx
    jmp .print_loop
.print_newline:
    mov rdi, newline
    xor eax, eax
    call printf
    jmp .get_command
