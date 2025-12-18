global main
extern printf
extern scanf

section .data
    ab_scanf_format: db "%lld %lld",0
    printf_format: db "%lld %lld %lld",10,0 ; gcd x y
    A dq 0
    B dq 0
    isChanged dq 0
    Nloop dq 0
    x dq 0
    y dq 1
    a dq 0
    b dq 0

section .text
main:
    sub rsp, 24
    mov rdi, ab_scanf_format
    lea rsi, [rsp]
    lea rdx, [rsp+8]
    xor rax, rax
    call scanf
    mov rax, [rsp]
    mov [A], rax ;A kochik taras
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
    
    ; --- شروع بخش بازگشتی ---
    call RecursiveGCD
    
    ; --- فیکس کردن استک (Stack Reversal) ---
    ; چون در بازگشت، آخرین مرحله میره ته استک و اولین مرحله میاد رو،
    ; و تابع FindAB انتظار داره آخرین مرحله رو باشه، باید کل استک رو برعکس کنیم.
    
    cmp qword [Nloop], 1
    jle AfterReverse ; اگر 0 یا 1 لوپ بود نیاز به تغییر نیست

    ; محاسبه تعداد کل اعداد در استک (هر لوپ 2 عدد: A و B)
    mov rcx, [Nloop]
    shl rcx, 1        ; ضرب در 2 (تعداد کلمات 8 بایتی)
    
    ; تنظیم اشاره‌گرها
    mov rsi, rsp             ; اشاره‌گر پایین (شروع استک)
    mov rdi, rsp
    mov rax, rcx
    dec rax
    shl rax, 3               ; ضرب در 8 (سایز هر خانه)
    add rdi, rax             ; اشاره‌گر بالا (ته داده‌ها)
    
    shr rcx, 1               ; تعداد دفعات جابجایی (نصف طول)

ReverseLoop:
    cmp rcx, 0
    je AfterReverse
    
    mov rax, [rsi]
    mov rbx, [rdi]
    mov [rsi], rbx   ; جابجایی
    mov [rdi], rax
    
    add rsi, 8       ; برو خانه بعدی
    sub rdi, 8       ; بیا خانه قبلی
    dec rcx
    jmp ReverseLoop

AfterReverse:
    jmp FindAB

; --------------------------------------------
; تابع بازگشتی GCD
; این تابع جایگزین لوپ FindGCD شده است
; --------------------------------------------
RecursiveGCD:
    ; شرط پایان: اگر A == 0 برگرد
    cmp qword [A], 0
    je .ReturnPoint

    ; 1. انجام تقسیم
    mov rax, [B]
    cqo
    idiv qword [A]
    
    ; 2. نگه داشتن مقادیر A و B فعلی در رجیسترهای safe (rbx, r12)
    ; چون میخوایم بعد از برگشت تابع (post-order) اینا رو پوش کنیم
    mov rbx, [A] ; A فعلی
    mov r12, [B] ; B فعلی
    
    ; 3. آپدیت مقادیر جهانی برای مرحله بعد
    mov [B], rbx  ; B جدید = A قدیم
    mov [A], rdx  ; A جدید = باقیمانده
    
    ; 4. افزایش شمارنده
    mov rax, [Nloop]
    inc rax
    mov [Nloop], rax
    
    ; 5. ذخیره موقت مقادیر در استک فریم برای حفظ در طول فراخوانی بازگشتی
    push rbx 
    push r12
    
    ; 6. فراخوانی خود تابع (Recursive Call)
    call RecursiveGCD
    
    ; 7. بازیابی مقادیر بعد از برگشت
    pop r12
    pop rbx
    
    ; 8. قرار دادن در استک اصلی برای استفاده در FindAB
    ; (اینجا مقادیر به ترتیب برعکس وارد استک میشن که در main درستش میکنیم)
    push rbx
    push r12
    
    ret

.ReturnPoint:
    ret

; --------------------------------------------
; FindAB - بدون تغییر نسبت به کد اصلی
; --------------------------------------------
FindAB:
    mov rax, [Nloop]
    cmp rax, 0
    je Chn
    pop rax
    mov [b], rax
    pop rax
    mov [a], rax
    mov rax, [b]
    cqo
    idiv qword [a]
    ; intertwined update for x and y
    mov r9, [x]    ; r9 = old x (temp)
    mov r11, r9    ; save old x for new y
    mov r10, [y]   ; r10 = old y
    imul r9, rax   ; r9 = q * old x
    sub r10, r9    ; r10 = old y - q * old x
    mov [x], r10   ; new x
    mov [y], r11   ; new y = old x
    mov rax, [Nloop]
    dec rax
    mov [Nloop], rax
    jmp FindAB

Chn:
    cmp qword [isChanged], 1
    jne End
    mov rax, [x]
    mov rbx, [y]
    mov [x], rbx
    mov [y], rax
    
End:
    mov rdi, printf_format
    mov rsi, [B] ; gcd
    mov rdx, [x]
    mov rcx, [y]
    xor rax, rax
    call printf
    add rsp, 24
    mov eax, 0
    ret
