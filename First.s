global main

section .data
A dq 0
B dq 0
counter dq 0
powTen dq 1     ; (نیازی نیست اما نگه داشتم)
powTenA dq 1    ; (نیازی نیست اما نگه داشتم)
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
    ; پاکسازی بافر ورودی با صفر (اختیاری ولی برای امنیت خوب است)
    ; فعلا همان خواندن عادی را انجام می‌دهیم
    
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
    
    ; تشخیص اینکه دستور div است یا mul برای تنظیم آفست شروع خواندن
    mov rbx, 4          ; فرض می کنیم طول دستور 4 است (div یا mul با فاصله)
    
    ; رجیستر r12 را برای ذخیره علامت عدد اول استفاده میکنیم (0 مثبت، 1 منفی)
    xor r12, r12 

; --- اینجا عدد اول (سمت چپ) را می خوانیم و در A ذخیره میکنیم ---
; (با اینکه لیبل FindB است، اما عدد اول را در A میریزیم تا تقسیم A بر B درست شود)
FindB:
    movzx r15, byte [input + rbx]
    
    ; بررسی علامت منفی برای عدد اول
    cmp r15, '-'
    jne .checkDigit
    mov r12, 1          ; علامت منفی دارد
    inc rbx
    jmp FindB

.checkDigit:
    cmp r15, ' '        ; رسیدن به فاصله یعنی پایان عدد اول
    je FindA
    cmp r15, 10         ; خط جدید (محافظت)
    je Calculate
    
    sub r15, '0'
    
    ; فرمول صحیح: A = (A * 10) + digit
    mov rax, [A]
    imul rax, 10
    add rax, r15
    mov [A], rax
    
    inc rbx
    jmp FindB

; --- اینجا عدد دوم را می خوانیم و در B ذخیره میکنیم ---
FindA:
    inc rbx             ; رد کردن فاصله بین دو عدد
    xor r13, r13        ; r13 برای علامت عدد دوم

NextA:
    movzx r15, byte [input + rbx]
    
    cmp r15, '-'
    jne .checkDigitA
    mov r13, 1          ; علامت منفی دارد
    inc rbx
    jmp NextA

.checkDigitA:
    cmp r15, 10         ; رسیدن به انتهای خط
    je ApplySigns
    cmp r15, 0
    je ApplySigns
    
    sub r15, '0'
    
    ; فرمول صحیح: B = (B * 10) + digit
    mov rax, [B]
    imul rax, 10
    add rax, r15
    mov [B], rax
    
    inc rbx
    jmp NextA

ApplySigns:
    ; اعمال علامت منفی روی A اگر لازم بود
    cmp r12, 1
    jne .signB
    neg qword [A]

.signB:
    ; اعمال علامت منفی روی B اگر لازم بود
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
    cqo                 ; گسترش بیت علامت برای تقسیم صحیح
    idiv qword [B]
    jmp PrintNumber

clcM:
    mov rax, [A]
    imul rax, [B]       ; ضرب علامت دار
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

    ; بررسی منفی بودن نتیجه برای چاپ
    mov r8, rax         ; کپی عدد در r8
    test rax, rax
    jge .conv
    neg rax             ; مثبت کردن موقت برای تبدیل به رشته

.conv:
    xor rdx, rdx
    div rbx
    add dl, '0'
    mov [rsi], dl
    dec rsi
    test rax, rax
    jnz .conv

    ; اگر عدد اصلی منفی بود، علامت منفی را اضافه کن
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
    add rsi, 5          ; پرش از روی کلمه "trim "
    mov rdi, output
    xor rcx, rcx
    mov byte [seeSpace], 0 ; پیش‌فرض 0 میگذاریم

.trimLoop:
    mov al, [rsi]
    cmp al, 10
    je .done
    cmp al, 0
    je .done
    
    ; بررسی فاصله و تب
    cmp al, ' '
    je .space
    cmp al, 9
    je .space

    ; کاراکتر غیر فاصله
    mov byte [seeSpace], 0
    mov [rdi], al
    inc rdi
    inc rsi
    jmp .trimLoop

.space:
    cmp byte [seeSpace], 1
    je .skip            ; اگر قبلا فاصله دیدیم، این را رد کن
    
    mov byte [seeSpace], 1
    mov byte [rdi], ' '
    inc rdi
.skip:
    inc rsi
    jmp .trimLoop

.done:
    mov byte [rdi], 10
    inc rdi
    mov rax, 1
    mov rdi, 1
    mov rsi, output
    mov rdx, rdi
    sub rdx, output     ; محاسبه طول دقیق
    syscall
    jmp MainLoop

lower:
    mov rsi, input
    add rsi, 6          ; پرش از روی کلمه "lower "
    mov rdi, output

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
    mov rax, 1
    mov rdi, 1
    mov rsi, output
    mov rdx, rdi
    sub rdx, output
    syscall
    jmp MainLoop

Exit:
    mov rax, 60
    xor rdi, rdi
    syscall
