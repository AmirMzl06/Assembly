global asm_main

extern printf
extern scanf

section .data
ab_scanf_format: db "%lld %lld",0
printf_format:   db "%lld %lld %lld",10,0   ; gcd x y

A dq 0
B dq 0
isChanged dq 0
Nloop dq 0

; متغیرهای نهایی برای ضرایب
x  dq 0
y  dq 0

; متغیرهای کمکی برای محاسبه
a dq 0
b dq 0

section .text
asm_main:
    sub rsp, 24

    mov rdi, ab_scanf_format
    lea rsi, [rsp]
    lea rdx, [rsp+8]
    xor rax, rax
    call scanf

    mov rax, [rsp]
    mov [A], rax    
    mov rax, [rsp+8]
    mov [B], rax

    mov qword [Nloop], 0
    mov qword [isChanged], 0
    mov rax,[A]
    cmp rax,[B]
    jl Change
    
    jmp Continue

Change:
    mov rax, [A]
    mov rbx, [B]
    mov [A], rbx
    mov [B], rax
    mov qword [isChanged], 1
     

Continue:
    mov rax, [A]
    cmp rax, 0
    je End
    
FindGCD:
    ; محاسبه خارج قسمت و باقی‌مانده
    mov rax, [B]
    cqo
    idiv qword [A]
    
    ; ذخیره مقادیر فعلی در استک برای بازگشت
    mov rbx, [A]
    push rbx
    mov rbx, [B]
    push rbx

    ; آپدیت مقادیر برای دور بعد
    ; B = A
    ; A = Remainder (rdx)
    mov rbx, [A]
    mov [B], rbx
    mov [A], rdx

    mov rax, [Nloop]
    inc rax
    mov [Nloop], rax

    cmp rdx, 0
    jne FindGCD
    
    ; --- شروع بخش اصلاح شده ---
    
    ; مقداردهی اولیه برای بازگشت (Back-substitution)
    ; در آخرین مرحله: 0*A + 1*B = GCD
    ; پس x (ضریب A) باید 0 باشد و y (ضریب B) باید 1 باشد
    mov qword [x], 0
    mov qword [y], 1

FindAB:
    mov rax, [Nloop]
    cmp rax, 0
    je Chn

    ; بازیابی مقادیر
    pop rax
    mov [b], rax    ; مقدار بزرگتر این مرحله
    pop rax
    mov [a], rax    ; مقدار کوچکتر این مرحله

    ; محاسبه مجدد خارج قسمت (Quotient)
    mov rax, [b]
    cqo
    idiv qword [a]  ; rax = quotient (q)

    ; فرمول بازگشتی اقلیدس:
    ; new_x = old_y - (q * old_x)
    ; new_y = old_x
    
    mov rbx, [x]    ; rbx = old_x
    mov rcx, [y]    ; rcx = old_y

    ; محاسبه q * old_x
    imul rax, rbx   ; rax = q * x

    ; محاسبه old_y - (q * old_x)
    sub rcx, rax    ; rcx = y - q*x
    
    ; آپدیت متغیرها
    mov [x], rcx    ; x = new_x
    mov [y], rbx    ; y = new_y (که همان old_x است)

    mov rax, [Nloop]
    dec rax
    mov [Nloop], rax
    jmp FindAB
    
    ; --- پایان بخش اصلاح شده ---

Chn:
    cmp qword [isChanged], 1
    jne End

    ; اگر جای A و B را اول کار عوض کردیم، الان جای ضرایب را عوض می‌کنیم
    mov rax, [x]
    mov rbx, [y]
    mov [x], rbx
    mov [y], rax

End:
    mov rdi, printf_format
    mov rsi, [B]    ; gcd
    mov rdx, [x]
    mov rcx, [y]
    xor rax, rax
    call printf

    add rsp, 24
    xor eax, eax
    ret
