; فایل: convolution.asm
; اسمبلی x86-64 برای convolution ساده

section .text
    global convolve_asm

; تابع: convolve_asm
; ورودی: 
;   rdi = pointer to image array
;   rsi = pointer to kernel array
;   rdx = pointer to result array
;   rcx = width
;   r8  = height
convolve_asm:
    push rbp
    mov rbp, rsp
    push rbx
    
    ; ذخیره پارامترها
    mov [img_ptr], rdi
    mov [kernel_ptr], rsi
    mov [result_ptr], rdx
    mov [width], rcx
    mov [height], r8
    
    ; حلقه اصلی - فعلاً یه جمع ساده
    xor rax, rax    ; i = 0
    
.loop_rows:
    cmp rax, [height]
    jge .done
    
    xor rbx, rbx    ; j = 0
    
.loop_cols:
    cmp rbx, [width]
    jge .next_row
    
    ; محاسبه آدرس در آرایه
    mov rcx, rax
    imul rcx, [width]
    add rcx, rbx
    shl rcx, 2      ; * 4 (چون float 4 بایته)
    
    ; آدرس عنصر در image
    mov rsi, [img_ptr]
    add rsi, rcx
    
    ; آدرس عنصر در result
    mov rdi, [result_ptr]
    add rdi, rcx
    
    ; کپی کردن مقدار (فعلاً ساده)
    movss xmm0, [rsi]
    movss [rdi], xmm0
    
    inc rbx
    jmp .loop_cols
    
.next_row:
    inc rax
    jmp .loop_rows
    
.done:
    pop rbx
    pop rbp
    ret

section .data
    img_ptr: dq 0
    kernel_ptr: dq 0
    result_ptr: dq 0
    width: dq 0
    height: dq 0
