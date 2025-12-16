global main
extern printf
extern scanf

section .data
ab_scanf_format: db "%lld %lld",0
printf_format:   db "%lld %lld %lld",10,0 ; gcd x y

; متغیرهای برنامه
A dq 0
B dq 0

; برای نگهداری خارج‌قسمت‌ها (q) — ظرفیت 256 کافی است
qspace: times 256 dq 0
Nloop dq 0

; متغیرهای برای ضرایب
x dq 0
y dq 0
x0 dq 1
y0 dq 0
x1 dq 0
y1 dq 1

section .text
main:
    ; فضای محلی برای scanf/printf (همانند کد اصلی)
    sub rsp, 24

    ; خواندن ورودی
    mov rdi, ab_scanf_format
    lea rsi, [rsp]
    lea rdx, [rsp+8]
    xor rax, rax
    call scanf

    mov rax, [rsp]
    mov [A], rax
    mov rax, [rsp+8]
    mov [B], rax

    ; اگر B == 0 بلافاصله خروجی بده (gcd = A, x=1, y=0)
    mov rax, [B]
    cmp rax, 0
    je PrintResult

    ; صفر کردن شمارنده خروجی‌ها
    mov qword [Nloop], 0

FindGCD:
    ; q = A / B ; r = A % B
    mov rax, [A]
    cqo
    idiv qword [B]     ; rax = q ، rdx = r

    ; ذخیره q در qspace[Nloop]
    mov rcx, [Nloop]
    mov [qspace + rcx*8], rax
    inc qword [Nloop]

    ; A = B ; B = r
    mov rax, [B]
    mov [A], rax
    mov rax, rdx
    mov [B], rax

    ; تکرار تا زمانی که B == 0
    mov rax, [B]
    cmp rax, 0
    jne FindGCD

    ; در این‌جا gcd در [A] قرار دارد

    ; اگر هیچ خارج‌قسمتی ذخیره نشده (مثلاً موقعی که ابتدای کار B==0) از این مرحله بگذر
    mov rax, [Nloop]
    cmp rax, 0
    je PrintResult

FindAB:
    ; بازسازی ضرایب با خواندن خارج‌قسمت‌ها از qspace از آخر به اول
    ; s0=x0, s1=x1 ; t0=y0, t1=y1
LoopBack:
    ; بارگذاری آخرین خارج‌قسمت: index = Nloop - 1
    mov rcx, [Nloop]
    dec rcx
    mov rax, [qspace + rcx*8]   ; rax = q

    ; محاسبه x = x0 - q * x1
    mov r9, [x1]
    imul r9, rax        ; r9 = q * x1
    mov r10, [x0]
    sub r10, r9         ; r10 = x0 - q*x1
    mov [x], r10

    ; shift: x0 = x1 ; x1 = x
    mov r11, [x1]
    mov [x0], r11
    mov r11, [x]
    mov [x1], r11

    ; محاسبه y = y0 - q * y1
    mov r9, [y1]
    imul r9, rax        ; r9 = q * y1
    mov r10, [y0]
    sub r10, r9         ; r10 = y0 - q*y1
    mov [y], r10

    ; shift: y0 = y1 ; y1 = y
    mov r11, [y1]
    mov [y0], r11
    mov r11, [y]
    mov [y1], r11

    ; کاهش شمارنده و تکرار تا صفر شدن
    mov rbx, [Nloop]
    dec rbx
    mov [Nloop], rbx
    cmp rbx, 0
    jne LoopBack

PrintResult:
    ; پرینت: gcd , x0 , y0
    mov rdi, printf_format
    mov rsi, [A]      ; gcd
    mov rdx, [x0]     ; x
    mov rcx, [y0]     ; y
    xor rax, rax
    call printf

    add rsp, 24
    mov eax, 0
    ret
