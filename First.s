global main
extern printf
extern scanf

section .data
nm_scanf_format db "%lld %lld",0
array_num_scanf db "%lld",0
cmd_scanf_format db "%s %lld %lld",0
printMin db "%lld",10,0
printArray db "%lld ",0
printNewLine db 10,0

n dq 0
m dq 0
arrayC dq 0
firstNum dq 0
secondNum dq 0
min dq 0

section .bss
num_array resq 200
cmd resb 10

section .text

main:
    sub rsp, 32

    mov rdi, nm_scanf_format
    lea rsi, [n]
    lea rdx, [m]
    call scanf

    jmp getArray

getArray:
    mov rax, [arrayC]
    cmp rax, [n]
    je getCommand

    mov rdi, array_num_scanf
    lea rsi, [num_array + rax*8]
    call scanf

    inc qword [arrayC]
    jmp getArray

getCommand:
    cmp qword [m], 0
    je end

    mov rdi, cmd_scanf_format
    lea rsi, [cmd]
    lea rdx, [firstNum]
    lea rcx, [secondNum]
    call scanf

    mov al, [cmd]
    cmp al, 'm'
    je minCmd
    cmp al, 's'
    je sort
    cmp al, 'r'
    je reserve
    cmp al, 'p'
    je print

    jmp getCommand

minCmd:
    mov r8, [firstNum]
    mov rax, [num_array + r8*8]
    mov [min], rax

cMin:
    cmp r8, [secondNum]
    je printMinCmd

    inc r8
    mov rax, [num_array + r8*8]
    cmp rax, [min]
    jge cMin
    mov [min], rax
    jmp cMin

printMinCmd:
    mov rdi, printMin
    mov rsi, [min]
    call printf

    dec qword [m]
    jmp getCommand

print:
    mov r8, [firstNum]

pLoop:
    cmp r8, [secondNum]
    jg printNL

    mov rdi, printArray
    mov rsi, [num_array + r8*8]
    call printf

    inc r8
    jmp pLoop

printNL:
    mov rdi, printNewLine
    call printf

    dec qword [m]
    jmp getCommand

sort:
    mov r8, [firstNum]

outer_loop:
    cmp r8, [secondNum]
    jge sort_done

    mov r9, r8
    inc r9

inner_loop:
    cmp r9, [secondNum]
    jg next_i

    mov r10, [num_array + r8*8]
    mov r11, [num_array + r9*8]

    cmp r10, r11
    jle no_swap

    mov [num_array + r8*8], r11
    mov [num_array + r9*8], r10

no_swap:
    inc r9
    jmp inner_loop

next_i:
    inc r8
    jmp outer_loop

sort_done:
    dec qword [m]
    jmp getCommand

reserve:
    mov r8, [firstNum]
    mov r9, [secondNum]

rev_loop:
    cmp r8, r9
    jge rev_done

    mov r10, [num_array + r8*8]
    mov r11, [num_array + r9*8]

    mov [num_array + r8*8], r11
    mov [num_array + r9*8], r10

    inc r8
    dec r9
    jmp rev_loop

rev_done:
    dec qword [m]
    jmp getCommand

end:
    add rsp, 32
    ret
