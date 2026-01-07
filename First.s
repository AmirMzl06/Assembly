global main
extern printf, scanf

section .data
    n_input     db "%d",0
    input       db "%lld",0
    cmd_input1  db "%s %lld",0
    cmd_input2  db "%s %lld %lld",0

    output      db "%lld ",0
    output2     db "%lld",10,0
    newline     db 10,0

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

; ------------ Read numbers ------------
get_number:
    mov rax, [counter]
    cmp rax, [n]
    je get_command
    mov rdi, input
    lea rsi, [array + rax*8]
    xor eax, eax
    call scanf
    inc qword [counter]
    jmp get_number

; ------------ Read command ------------
get_command:
    mov rdi, cmd_input1
    lea rsi, [cmd]
    lea rdx, [idx1]
    xor eax, eax
    call scanf

    ; بررسی حرف اول دستور
    mov al, byte [cmd]
    cmp al, 'e'
    je do_exit
    cmp al, 'n'
    je do_neg
    cmp al, 'p'
    je do_pow
    cmp al, 'z'
    je do_zero
    cmp al, 'r'
    je do_round
    cmp al, 's'
    je check_sort
    cmp al, 'm'
    je check_maxmin
    cmp al, 'l'
    je check_low
    cmp al, 'h'
    je do_high
    cmp al, 'p'
    je do_print
    jmp get_command

; ------------ Commands ------------
do_exit:
    add rsp, 40
    xor eax, eax
    ret

do_neg:
    mov rdx, [idx1]
    mov rax, [array + rdx*8]
    neg rax
    mov [array + rdx*8], rax
    jmp get_command

do_pow:
    mov rdx, [idx1]
    mov rax, [array + rdx*8]
    imul rax, rax
    mov [array + rdx*8], rax
    jmp get_command

do_zero:
    mov rdx, [idx1]
    mov qword [array + rdx*8], 0
    jmp get_command

do_round:
    mov rdx, [idx1]
    mov rax, [array + rdx*8]
    mov [array + rdx*8], rax
    jmp get_command

check_sort:
    mov al, byte [cmd+4]
    cmp al, 'a'
    je do_sorta
    cmp al, 'd'
    je do_sortd
    jmp get_command

do_sorta:
    mov r11, [idx1]
    mov r12, [idx2]
    inc r12
.outerA:
    cmp r11, r12
    jge get_command
    mov r13, r11
    mov r14, r11
.innerA:
    inc r14
    cmp r14, r12
    jge .swapA
    mov rax, [array + r14*8]
    mov rbx, [array + r13*8]
    cmp rbx, rax
    jbe .innerA
    mov r13, r14
    jmp .innerA
.swapA:
    mov rax, [array + r11*8]
    mov rbx, [array + r13*8]
    mov [array + r11*8], rbx
    mov [array + r13*8], rax
    inc r11
    jmp .outerA

do_sortd:
    mov r11, [idx1]
    mov r12, [idx2]
    inc r12
.outerD:
    cmp r11, r12
    jge get_command
    mov r13, r11
    mov r14, r11
.innerD:
    inc r14
    cmp r14, r12
    jge .swapD
    mov rax, [array + r14*8]
    mov rbx, [array + r13*8]
    cmp rbx, rax
    jle .innerD
    mov r13, r14
    jmp .innerD
.swapD:
    mov rax, [array + r11*8]
    mov rbx, [array + r13*8]
    mov [array + r11*8], rbx
    mov [array + r13*8], rax
    inc r11
    jmp .outerD

check_maxmin:
    mov r11, [idx1]
    mov r12, [idx2]
    mov r15, [array + r11*8]
.findMax:
    inc r11
    cmp r11, r12
    jg .printMax
    mov rax, [array + r11*8]
    cmp r15, rax
    jge .findMax
    mov r15, rax
    jmp .findMax
.printMax:
    mov rdi, output2
    mov rsi, r15
    xor eax, eax
    call printf
    jmp get_command

check_low:
    ; low / lowa -> کمینه‌ها
    mov r11, [idx1]
    mov r12, [idx2]
    mov r15, [array + r11*8]
.findLow:
    inc r11
    cmp r11, r12
    jg .printLow
    mov rax, [array + r11*8]
    cmp rax, r15
    jge .findLow
    mov r15, rax
    jmp .findLow
.printLow:
    mov rdi, output2
    mov rsi, r15
    xor eax, eax
    call printf
    jmp get_command

do_high:
    ; high -> بزرگترین قدر مطلق
    mov r11, [idx1]
    mov r12, [idx2]
    mov rax, [array + r11*8]
    mov r15, rax
.findHigh:
    inc r11
    cmp r11, r12
    jg .printHigh
    mov rax, [array + r11*8]
    mov rbx, rax
    test rbx, rbx
    jns .positive
    neg rbx
.positive:
    cmp rbx, r15
    jle .findHigh
    mov r15, rax
    jmp .findHigh
.printHigh:
    mov rdi, output2
    mov rsi, r15
    xor eax, eax
    call printf
    jmp get_command

do_print:
    mov r11, [idx1]
    mov r12, [idx2]
.print_loop:
    cmp r11, r12
    jg .print_newline
    mov rdi, output
    mov rsi, [array + r11*8]
    xor eax, eax
    call printf
    inc r11
    jmp .print_loop
.print_newline:
    mov rdi, newline
    xor eax, eax
    call printf
    jmp get_command
