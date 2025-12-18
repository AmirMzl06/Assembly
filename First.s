global main
extern printf
extern scanf

section .data
    ab_scanf_format: db "%lld %lld",0
    printf_format:   db "%lld %lld %lld",10,0

    A dq 0
    B dq 0
    isChanged dq 0

    x dq 0
    y dq 1

section .text

;--------------------------------------------------
; ExtGCD (بازگشتی) - محاسبه‌ی ضرایب x,y طوری که
; A*x + B*y = gcd(A,B)
; در این پیاده‌سازی A و B در حافظه (labels A,B) قرار دارند
; از r12,r13 به عنوان رجیسترهای محافظت‌شده استفاده می‌کنیم
;--------------------------------------------------
ExtGCD:
    ; save callee-saved temps (push two regs -> keeps alignment)
    push    r12
    push    r13

    mov     rax, [A]
    test    rax, rax
    je      .base_case

    ; compute q = B / A  and remainder in rdx
    mov     rax, [B]
    cqo
    idiv    qword [A]      ; quotient in rax, remainder in rdx

    mov     r12, rax       ; r12 := q (saved across recursive call)
    mov     r13, [A]       ; r13 := old A

    ; rotate (A,B) := (rdx, oldA)
    mov     [B], r13       ; B = oldA
    mov     [A], rdx       ; A = remainder

    call    ExtGCD

    ; after return: x,y contain x1,y1 for (A_new,B_new)
    ; r12 still holds q (callee-saved restored by recursion)

    ; compute: new_x = y1 - q * x1
    ;          new_y = x1

    mov     r13, [x]       ; r13 = x1
    imul    r13, r12       ; r13 = q * x1
    mov     rdx, [y]       ; rdx = y1
    sub     rdx, r13       ; rdx = y1 - q*x1  => new_x

    mov     r13, [x]       ; reload x1
    mov     [x], rdx       ; store new_x
    mov     [y], r13       ; store new_y = x1

    ; restore saved regs and return
    pop     r13
    pop     r12
    ret

.base_case:
    ; A == 0 -> gcd = B  ; coefficients: x = 0, y = 1  (i.e. 0*A + 1*B = B)
    mov     qword [x], 0
    mov     qword [y], 1

    pop     r13
    pop     r12
    ret

;--------------------------------------------------
; main: خواندن ورودی، احتمالاً جابه‌جا کردن A و B
; و فراخوانی ExtGCD سپس چاپ
;--------------------------------------------------
main:
    sub     rsp, 24               ; فضای محلی برای scanf

    mov     rdi, ab_scanf_format
    lea     rsi, [rsp]
    lea     rdx, [rsp+8]
    xor     rax, rax
    call    scanf

    mov     rax, [rsp]
    mov     rbx, [rsp+8]

    mov     [A], rax
    mov     [B], rbx
    mov     qword [isChanged], 0

    ; اگر A > B، جابجا کن تا A همیشه کوچکتر باشد
    mov     rax, [A]
    cmp     rax, [B]
    jg      .do_swap
    jmp     .call_ext

.do_swap:
    mov     rax, [A]
    mov     rbx, [B]
    mov     [A], rbx
    mov     [B], rax
    mov     qword [isChanged], 1

.call_ext:
    call    ExtGCD

    ; چاپ: gcd (در [B]) سپس x و y مربوط به (A,B) فعلی
    mov     rdi, printf_format
    mov     rsi, [B]    ; gcd
    mov     rdx, [x]
    mov     rcx, [y]
    xor     rax, rax
    call    printf

    add     rsp, 24
    xor     eax, eax
    ret
