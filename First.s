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
    
    ; فراخوانی تابع بازگشتی
    call RecursiveGCD
    
    ; چون بازگشت استک را برعکس پر می‌کند، باید آن را مرتب کنیم تا FindAB درست کار کند
    call ReverseStack
    
    jmp FindAB

; --------------------------------------------
; تابع بازگشتی GCD
; --------------------------------------------
RecursiveGCD:
    ; شرط پایان: اگر A == 0 برگرد
    cmp qword [A], 0
    je .DoneRec

    ; مقادیر فعلی را برای استفاده بعد از بازگشت در پشته موقت (یا رجیسترها) نگه می‌داریم
    mov rbx, [A] ; مقدار A فعلی
    mov rcx, [B] ; مقدار B فعلی
    
    ; محاسبه تقسیم و آپدیت A و B برای مرحله بعد
    mov rax, [B]
    cqo
    idiv qword [A]
    
    ; آپدیت گلوبال‌ها برای فراخوانی بعدی
    mov [B], rbx  ; B جدید = A قدیم
    mov [A], rdx  ; A جدید = باقیمانده
    
    ; افزایش شمارنده
    mov rax, [Nloop]
    inc rax
    mov [Nloop], rax
    
    ; مقادیر قدیم رو توی استک فریم نگه میداریم (با پوش کردن قبل از کال)
    push rbx ; Old A
    push rcx ; Old B
    
    call RecursiveGCD
    
    ; بعد از بازگشت، مقادیر رو برای FindAB در استک اصلی قرار میدیم
    ; نکته: چون اینجا داریم آنوایند (Unwind) میکنیم، اولین پوش مربوط به آخرین مرحله است
    ; این باعث میشه ترتیب برعکس حالتِ لوپ معمولی باشه
    pop rcx ; بازیابی Old B
    pop rbx ; بازیابی Old A
    
    push rbx ; پوش کردن برای FindAB
    push rcx ; پوش کردن برای FindAB
    
    ret

.DoneRec:
    ret

; --------------------------------------------
; تابع معکوس کردن استک (برای هماهنگی با FindAB)
; --------------------------------------------
ReverseStack:
    cmp qword [Nloop], 1
    jle .NoReverse ; اگر 0 یا 1 لوپ بود نیاز به تغییر نیست

    ; ما باید 2 * Nloop آیتم را در استک معکوس کنیم (چون هر لوپ 2 عدد پوش میکنه)
    mov rcx, [Nloop] 
    imul rcx, 2      ; تعداد کل اعداد در استک (A و B برای هر مرحله)
    
    ; الگوریتم ساده برای معکوس کردن محتوای استک
    ; استفاده از دو اشاره‌گر: یکی پایین استک (rsp) و یکی بالای داده‌ها
    
    mov rsi, rsp             ; اشاره‌گر پایین (Low)
    mov rdi, rsp
    mov rax, rcx
    dec rax
    shl rax, 3               ; ضرب در 8 (سایز qword)
    add rdi, rax             ; اشاره‌گر بالا (High)
    
    shr rcx, 1               ; تعداد جابجایی‌ها (تعداد کل / 2)
    
.ReverseLoop:
    cmp rcx, 0
    je .NoReverse
    
    mov rax, [rsi]
    mov rbx, [rdi]
    mov [rsi], rbx
    mov [rdi], rax
    
    add rsi, 8
    sub rdi, 8
    dec rcx
    jmp .ReverseLoop
    
.NoReverse:
    ret

; --------------------------------------------
; همان تابع FindAB اصلی بدون تغییر
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
