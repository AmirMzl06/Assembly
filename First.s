; ============================================
; فایل: convolution_complete.asm
; پروژه: پیاده‌سازی Convolution با دستورات SIMD
; معماری: x86-64
; ============================================

section .data
    align 16
    float_one dw 1.0
    
section .bss
    img_ptr:    resq 1
    kernel_ptr: resq 1
    result_ptr: resq 1
    width:      resq 1
    height:     resq 1
    k_size:     resq 1      ; اندازه فیلتر (مثلاً 3 برای 3x3)
    pad:        resq 1       ; مقدار padding

section .text
    global convolve_asm
    global convolve_sse
    global convolve_avx

; ============================================
; تابع اصلی: convolve_asm
; ورودی:
;   rdi = pointer to image array (float*)
;   rsi = pointer to kernel array (float*)
;   rdx = pointer to result array (float*)
;   rcx = width
;   r8  = height
;   r9  = kernel_size (مثلاً 3 برای 3x3)
; ============================================
convolve_asm:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13
    push r14
    push r15
    
    ; ذخیره پارامترها
    mov [img_ptr], rdi
    mov [kernel_ptr], rsi
    mov [result_ptr], rdx
    mov [width], rcx
    mov [height], r8
    mov [k_size], r9
    
    ; محاسبه padding
    mov rax, r9
    shr rax, 1          ; تقسیم بر 2 = padding
    mov [pad], rax
    
    ; بررسی اینکه از SSE استفاده کنیم یا AVX
    cmp r9, 3
    je .use_sse         ; برای فیلتر 3x3 از SSE استفاده کن
    jmp .use_avx        ; برای بزرگتر از AVX استفاده کن
    
.use_sse:
    call convolve_sse_3x3
    jmp .done
    
.use_avx:
    call convolve_avx_general
    
.done:
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    pop rbp
    ret

; ============================================
; پیاده‌سازی با SSE برای فیلتر 3x3
; ============================================
convolve_sse_3x3:
    push rbp
    mov rbp, rsp
    
    mov r12, [height]
    mov r13, [width]
    mov r14, [img_ptr]
    mov r15, [kernel_ptr]
    
    ; بارگذاری فیلتر 3x3 در ثبات‌های SSE
    movups xmm4, [r15]          ; بارگذاری 4 عنصر اول فیلتر
    movups xmm5, [r15 + 16]     ; بارگذاری 4 عنصر بعدی (آخرین عنصر اضافه‌ست)
    
    xor rbx, rbx                ; rbx = i (سطر)
    
.loop_height:
    cmp rbx, r12
    jge .end_function
    
    xor rcx, rcx                ; rcx = j (ستون)
    
.loop_width:
    cmp rcx, r13
    jge .next_row
    
    ; محاسبه آدرس شروع پنجره
    mov rax, rbx
    sub rax, 1                  ; i-1 (padding)
    imul rax, r13
    add rax, rcx
    sub rax, 1                  ; j-1
    shl rax, 2                  ; *4 برای float
    
    ; آدرس شروع پنجره 3x3
    lea rsi, [r14 + rax]
    
    ; بارگذاری 3 سطر از تصویر
    ; سطر اول
    movups xmm0, [rsi]          ; 4 عنصر اول سطر اول
    movups xmm1, [rsi + r13*4]   ; سطر دوم
    movups xmm2, [rsi + r13*8]   ; سطر سوم
    
    ; ضرب با فیلتر و جمع
    mulps xmm0, xmm4            ; ضرب سطر اول با بخش اول فیلتر
    mulps xmm1, xmm5            ; ضرب سطر دوم با بخش دوم فیلتر
    
    ; جمع کردن نتایج
    addps xmm0, xmm1
    
    ; جمع عناصر xmm0 با هم (horizontal sum)
    movaps xmm1, xmm0
    shufps xmm1, xmm1, 0x4E     ; جابجایی
    addps xmm0, xmm1
    movaps xmm1, xmm0
    shufps xmm1, xmm1, 0xB1     ; جابجایی دیگر
    addps xmm0, xmm1
    
    ; استخراج نتیجه
    movss xmm2, xmm0            ; کم ارزش‌ترین 32 بیت = نتیجه
    
    ; ذخیره نتیجه
    mov rax, rbx
    imul rax, r13
    add rax, rcx
    shl rax, 2
    add rax, [result_ptr]
    movss [rax], xmm2
    
    inc rcx
    jmp .loop_width
    
.next_row:
    inc rbx
    jmp .loop_height
    
.end_function:
    pop rbp
    ret

; ============================================
; پیاده‌سازی با AVX برای فیلترهای بزرگتر
; ============================================
convolve_avx_general:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    
    mov r12, [height]
    mov r13, [width]
    mov r14, [img_ptr]
    mov r15, [kernel_ptr]
    mov r11, [k_size]
    
    xor rbx, rbx                ; i = 0
    
.avx_loop_height:
    cmp rbx, r12
    jge .avx_end
    
    xor rcx, rcx                ; j = 0
    
.avx_loop_width:
    cmp rcx, r13
    jge .avx_next_row
    
    vxorps ymm0, ymm0, ymm0     ; نتیجه رو صفر کن
    
    xor r8, r8                  ; ki = 0
    
.avx_loop_kernel_y:
    cmp r8, r11
    jge .avx_store_result
    
    xor r9, r9                  ; kj = 0
    
.avx_loop_kernel_x:
    cmp r9, r11
    jge .avx_next_kernel_y
    
    ; محاسبه آدرس پیکسل تصویر
    mov rax, rbx
    add rax, r8
    sub rax, [pad]              ; i + ki - pad
    imul rax, r13
    add rax, rcx
    add rax, r9
    sub rax, [pad]              ; j + kj - pad
    shl rax, 2
    
    ; محاسبه آدرس عنصر فیلتر
    mov r10, r8
    imul r10, r11
    add r10, r9
    shl r10, 2
    
    ; بارگذاری مقدار
    vmovss xmm1, [r14 + rax]
    vmovss xmm2, [r15 + r10]
    
    ; ضرب
    vmulss xmm1, xmm1, xmm2
    
    ; جمع با نتیجه
    vaddss xmm0, xmm0, xmm1
    
    inc r9
    jmp .avx_loop_kernel_x
    
.avx_next_kernel_y:
    inc r8
    jmp .avx_loop_kernel_y
    
.avx_store_result:
    ; ذخیره نتیجه نهایی
    mov rax, rbx
    imul rax, r13
    add rax, rcx
    shl rax, 2
    vmovss [r14 + rax], xmm0    ; ذخیره در result
    
    inc rcx
    jmp .avx_loop_width
    
.avx_next_row:
    inc rbx
    jmp .avx_loop_height
    
.avx_end:
    vzeroupper                  ; پاک کردن ثبات‌های AVX
    leave
    ret

; ============================================
; تابع کمکی: جمع افقی برای SSE
; ===========================================
horizontal_sum_sse:
    ; ورودی: xmm0 دارای 4 عدد float
    ; خروجی: xmm0[0] = جمع همه
    movaps xmm1, xmm0
    shufps xmm1, xmm1, 0x4E     ; 0 1 2 3 -> 2 3 0 1
    addps xmm0, xmm1
    movaps xmm1, xmm0
    shufps xmm1, xmm1, 0xB1     ; 2 3 0 1 -> 3 2 1 0
    addps xmm0, xmm1
    ret

; ============================================
; تابع کمکی: clamp (محدود کردن مقادیر بین 0-255)
; ============================================
clamp_value:
    ; ورودی: xmm0 = مقدار
    ; خروجی: xmm0 = محدود شده بین 0 و 255
    pxor xmm1, xmm1
    maxss xmm0, xmm1            ; max(0, value)
    
    mov eax, 0x437F0000         ; 255.0 به صورت اعشاری
    movd xmm1, eax
    minss xmm0, xmm1            ; min(255, value)
    ret
