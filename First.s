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
    
    ; ماسک برای قدر مطلق (همه بیت‌ها 1 بجز بیت علامت)
    abs_mask    dq 0x7FFFFFFFFFFFFFFF
    ; ماسک جدید برای قرینه کردن (فقط بیت علامت 1 است)
    neg_mask    dq 0x8000000000000000

section .bss
    n           resq 1
    array       resq 100
    cmd         resb 16
    idx1        resq 1
    idx2        resq 1

section .text
main:
    push rbx        ; ذخیره رجیستر RBX چون از آن استفاده خواهیم کرد (Callee-saved)
    sub rsp, 8      ; تراز کردن پشته (Stack Alignment)
    
    ; دریافت تعداد اعداد (n)
    mov rdi, n_input
    mov rsi, n
    xor eax, eax
    call scanf

    mov rcx, [n]
    mov rdi, array
.get_number_loop:
    push rcx
    push rdi        ; آدرس فعلی آرایه را نگه می‌داریم
    mov rsi, rdi
    mov rdi, input
    xor eax, eax
    call scanf
    pop rdi         ; آدرس آرایه را بازیابی می‌کنیم
    pop rcx
    add rdi, 8      ; رفتن به خانه بعدی (double = 8 bytes)
    loop .get_number_loop

.get_command:
    mov rdi, cmd_input
    mov rsi, cmd
    xor eax, eax
    call scanf
    
    mov rdi, cmd
    
    ; بررسی دستور exit
    mov rsi, exit_str
    call strcmp
    test rax, rax
    jz .do_exit
    
    ; بررسی دستورات تک آرگومانی
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
    ; خواندن دو ایندکس برای دستورات بازه‌ای
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
    ; خواندن یک ایندکس برای دستورات تکی
    mov rdi, n_input
    mov rsi, idx1
    xor eax, eax
    call scanf

.dispatch:
    mov rdi, cmd
    
    ; مقایسه مجدد برای پرش به لیبل مناسب
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
    add rsp, 8
    pop rbx         ; بازیابی RBX
    xor eax, eax
    ret

.do_neg:
    mov rdx, [idx1]
    movsd xmm0, [array + rdx*8]
    movq xmm1, [neg_mask]       ; اصلاح: استفاده از ماسک بیت علامت
    xorpd xmm0, xmm1            ; XOR با 0x800... بیت علامت را عوض می‌کند
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
    roundsd xmm0, xmm0, 0       ; 0 = Round to nearest integer
    movsd [array + rdx*8], xmm0
    jmp .get_command

.do_sorta:
    mov r11, [idx1]
.outerA:
    mov r12, [idx2]
    cmp r11, r12
    jge .get_command        ; Selection sort تا یکی مانده به آخر کافیست
    mov r14, r11            ; r14 = ایندکس مینیمم
    mov r13, r11
.innerA:
    inc r13
    cmp r13, r12
    jg .swapA               ; اصلاح: jg برای بررسی تا آخرین عنصر (شامل idx2)
    movsd xmm0, [array + r13*8] ; عدد جاری
    movsd xmm1, [array + r14*8] ; عدد مینیمم فعلی
    ucomisd xmm1, xmm0
    jbe .innerA             ; اگر min <= curr ادامه بده
    mov r14, r13            ; وگرنه ایندکس مینیمم جدید را نگه دار
    jmp .innerA
.swapA:
    movsd xmm0, [array + r11*8]
    movsd xmm1, [array + r14*8]
    movsd [array + r11*8], xmm1
    movsd [array + r14*8], xmm0
    inc r11
    jmp .outerA

.do_sortd:
    mov r11, [idx1]
.outerD:
    mov r12, [idx2]
    cmp r11, r12
    jge .get_command
    mov r14, r11
    mov r13, r11
.innerD:
    inc r13
    cmp r13, r12
    jg .swapD
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
    
.do_maxc:
    mov r11, [idx1]
    mov r12, [idx2]
    movsd xmm0, [array + r11*8] ; xmm0 نگهدارنده ماکسیمم
.findMaxC:
    inc r11
    cmp r11, r12
    jg .fillMaxC            ; اصلاح: jg بجای jge تا عنصر آخر هم چک شود
    movsd xmm1, [array + r11*8]
    ucomisd xmm0, xmm1
    jae .findMaxC
    movsd xmm0, xmm1
    jmp .findMaxC
.fillMaxC:
    mov r11, [idx1]
.fillLoopC:
    mov r12, [idx2]
    cmp r11, r12
    jg .get_command         ; اصلاح: jg
    movsd [array + r11*8], xmm0
    inc r11
    jmp .fillLoopC

.do_lowa:
    mov r11, [idx1]
    mov r12, [idx2]
    movsd xmm0, [array + r11*8] ; xmm0 = مقدار نهایی
    movsd xmm1, xmm0
    andpd xmm1, [abs_mask]      ; xmm1 = قدرمطلق مینیمم فعلی
.findLowa:
    inc r11
    cmp r11, r12
    jg .fillLowa            ; اصلاح: jg
    movsd xmm2, [array + r11*8] ; مقدار جدید
    movsd xmm3, xmm2
    andpd xmm3, [abs_mask]      ; قدرمطلق جدید
    ucomisd xmm1, xmm3
    jbe .findLowa               ; اگر min_abs <= new_abs ادامه بده
    movsd xmm1, xmm3            ; آپدیت قدر مطلق
    movsd xmm0, xmm2            ; آپدیت مقدار واقعی
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

.do_print:
    ; اصلاح مهم: استفاده از RBX بجای R11
    ; printf رجیستر R11 را تغییر می‌دهد، پس نمی‌توان از آن به عنوان شمارنده استفاده کرد
    mov rbx, [idx1]
    mov r12, [idx2]
.print_loop:
    cmp rbx, r12
    jg .print_newline       ; اصلاح: jg برای چاپ آخرین عنصر
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

.do_max:
    mov r11, [idx1]
    mov r12, [idx2]
    movsd xmm0, [array + r11*8]
.max_loop:
    inc r11
    cmp r11, r12
    jg .print_val           ; اصلاح: jg
    movsd xmm1, [array + r11*8]
    ucomisd xmm0, xmm1
    jae .max_loop
    movsd xmm0, xmm1
    jmp .max_loop

.do_min:
    mov r11, [idx1]
    mov r12, [idx2]
    movsd xmm0, [array + r11*8]
.min_loop:
    inc r11
    cmp r11, r12
    jg .print_val           ; اصلاح: jg
    movsd xmm1, [array + r11*8]
    ucomisd xmm0, xmm1
    jbe .min_loop
    movsd xmm0, xmm1
    jmp .min_loop

.do_low:
    mov r11, [idx1]
    mov r12, [idx2]
    movsd xmm0, [array + r11*8]
    movsd xmm1, xmm0
    andpd xmm1, [abs_mask]
.low_loop:
    inc r11
    cmp r11, r12
    jg .print_val           ; اصلاح: jg
    movsd xmm2, [array + r11*8]
    movsd xmm3, xmm2
    andpd xmm3, [abs_mask]
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
    andpd xmm1, [abs_mask]
.high_loop:
    inc r11
    cmp r11, r12
    jg .print_val           ; اصلاح: jg
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
    jmp .get_command
