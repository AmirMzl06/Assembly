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

section .text

;---------------------------------------------------------------------
; تابع بازگشتی برای محاسبه ب.م.م و پر کردن پشته برای FindAB
; این تابع جایگزین حلقه FindGCD قبلی شده است.
;---------------------------------------------------------------------
FindGCD_Recursive:
    mov rax, [A]
    cmp rax, 0      ; شرط پایه: اگر A برابر صفر شود، ب.م.م در B قرار دارد و بازگشت تمام می‌شود
    je .end_recursion

    ; --- بخش بازگشتی ---
    ; مقادیر فعلی A و B را برای استفاده در FindAB روی پشته قرار می‌دهیم
    push qword [A]
    push qword [B]
    inc qword [Nloop]

    ; عملیات تقسیم: B = q*A + r
    mov rax, [B]    ; مقسوم
    cqo             ; RAX را برای تقسیم علامت‌دار گسترش می‌دهد
    idiv qword [A]  ; مقسوم علیه. خارج قسمت در RAX و باقیمانده در RDX

    ; مقادیر A و B را برای فراخوانی بازگشتی بعدی به‌روزرسانی می‌کنیم
    mov rbx, [A]    ; نگه‌داشتن مقدار قدیمی A
    mov [A], rdx    ; A جدید = باقیمانده
    mov [B], rbx    ; B جدید = A قدیمی
    
    call FindGCD_Recursive ; فراخوانی بازگشتی

.end_recursion:
    ret
;---------------------------------------------------------------------

main:
    ; آماده‌سازی پشته و خواندن ورودی‌ها
    sub rsp, 24
    mov rdi, ab_scanf_format
    lea rsi, [rsp]
    lea rdx, [rsp+8]
    xor rax, rax
    call scanf

    ; ذخیره ورودی‌ها در متغیرهای A و B
    mov rax, [rsp]
    mov [A], rax
    mov rax, [rsp+8]
    mov [B], rax

    mov qword [Nloop], 0
    mov qword [isChanged], 0

    ; اطمینان از اینکه A از B بزرگتر است
    mov rax, [A]
    cmp rax, [B]
    jl Change
    
    jmp Continue

Change:
    ; جابجایی مقادیر A و B
    mov rax, [A]
    mov rbx, [B]
    mov [A], rbx
    mov [B], rax
    mov qword [isChanged], 1
    
Continue:
    ; فراخوانی تابع بازگشتی برای محاسبه ب.م.م
    call FindGCD_Recursive
    ; پس از اتمام تابع، ب.م.م در [B] است و پشته برای FindAB آماده است

FindAB:
    mov rax, [Nloop]
    cmp rax, 0
    je Chn
    
    ; یک اصلاح کوچک: مقادیر از پشته در دو رجیستر متفاوت (rax و rbx) pop می‌شوند
    ; تا از بروز خطا جلوگیری شود.
    pop rbx ; مقدار B از یک مرحله قبل
    pop rax ; مقدار A از یک مرحله قبل
    
    ; محاسبه مجدد خارج قسمت (q) برای این مرحله
    push rax        ; ذخیره موقت rax (مقدار A)
    mov rax, rbx    ; انتقال مقدار B به rax برای تقسیم
    cqo
    idiv qword [rsp] ; تقسیم B بر A. خارج قسمت در rax
    pop rbx         ; بازیابی مقدار A در rbx (اینجا لازم نیست ولی برای خوانایی خوب است)
    
    ; به‌روزرسانی ضرایب x و y
    mov r9, [x]     ; r9 = x قدیمی
    mov r11, r9     ; ذخیره x قدیمی برای y جدید
    mov r10, [y]    ; r10 = y قدیمی
    imul r9, rax    ; r9 = q * x قدیمی
    sub r10, r9     ; r10 = y قدیمی - (q * x قدیمی)
    mov [x], r10    ; x جدید
    mov [y], r11    ; y جدید = x قدیمی
    
    dec qword [Nloop]
    jmp FindAB

Chn:
    ; اگر در ابتدا A و B جابجا شده بودند، ضرایب x و y هم جابجا می‌شوند
    cmp qword [isChanged], 1
    jne End
    mov rax, [x]
    mov rbx, [y]
    mov [x], rbx
    mov [y], rax

End:
    ; چاپ نتیجه نهایی
    mov rdi, printf_format
    mov rsi, [B] ; ب.م.م
    mov rdx, [x]
    mov rcx, [y]
    xor rax, rax
    call printf
    
    add rsp, 24
    mov eax, 0
    ret
