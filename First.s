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
    abs_mask    dq 0x7FFFFFFFFFFFFFFF    ; برای قدر مطلق
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

    ; check exit
    mov al, [cmd]
    cmp al, 'e'
    je .exit

    ; دستورات تک عضوی: n,p,z,r (neg,pow,zero,round)
    cmp al, 'n'
    je .read_one
    cmp al, 'p'
    je .read_one
    cmp al, 'z'
    je .read_one
    cmp al, 'r'
    je .read_one

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

.read_one:
    mov rdi, n_input
    lea rsi, [idx1]
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
    cmp al, 's'       ; sorta or sortd
    je .sort_check
    cmp al, 'm'       ; maxc or max
    je .max_check
    cmp al, 'l'       ; lowa or low
    je .low_check
    cmp al, 'p'       ; print
    je .print
    cmp al, 'h'       ; high
    je .high
    jmp getCommand

.sort_check:
    mov bl, [cmd+1]
    cmp bl, 'o'
    je .sorta
    cmp bl, 'o'
    je .sortd
    jmp getCommand

.max_check:
    mov bl, [cmd+1]
    cmp bl, 'a'       ; maxc
    je .maxc
    cmp bl, 0         ; max
    je .max
    jmp getCommand

.low_check:
    mov bl, [cmd+1]
    cmp bl, 'o'       ; lowa
    je .lowa
    cmp bl, 0         ; low
    je .low
    jmp getCommand

.neg:
    mov rdx, [idx1]
    cmp rdx, [n]
    jae getCommand
    movsd xmm0, [array + rdx*8]
    xorpd xmm1, xmm1
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

.exit:
    add rsp,40
    xor eax, eax
    ret
