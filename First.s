global asm_main
extern printf
extern scanf

section .data
scanf_format: db "%d %d %d", 0
printf_format: db "%d", 10, 0
Eror_format: db "Error",10,0


section .text
asm_main:
    sub rsp, 24
    mov rdi, scanf_format
    mov rsi, rsp
    lea rdx, [rsp+8]
    lea rcx, [rsp+16]
    call scanf

    cmp [rsp],0
    je Sum        
    cmp [rsp],1
    je Sub
    cmp [rsp],2
    je And
    cmp [rsp],3
    je Or
    ;cmp [rsp],4
    ;je Mul
    ;cmp [rsp],5
    ;je Div
    ;cmp [rsp],6
    ;je Pow
    
    Sum:
      add [rsp+8],[rsp+16]
      mov rdi,printf_format
      mov rsi,[rsp+8]
      call printf
      ret
    Sub:
      sub [rsp+8],[rsp+16]
      mov rdi,printf_format
      mov rsi,[rsp+8]
      call printf
      ret
    And:
      and [rsp+8],[rsp+16]
      mov rdi,printf_format
      mov rsi,[rsp+8]
      call printf
      ret
    Or:
      or [rsp+8],[rsp+16]
      mov rdi,printf_format
      mov rsi,[rsp+8]
      call printf
      ret
    ;Mul:
    ;  mul [rsp+8],[rsp+16]
    ;  mov rdi,printf_format
    ;  mov rsi,[rsp+8]
    ;  call printf
    ;  ret
    ;Div:
    ;cmp [rsp+16],0
    ;je PrintError
    
    ;div [rsp+8],[rsp+16]
    ;mov rdi,printf_format
    ;mov rsi,[rsp+8]
    ;call printf
    ;ret
    ;PrintError:
    ;  mov rdi,Error_format
    ;  call printf
    ;  ret
    ;Pow:
    ;  pov [rsp+8],[rsp+16]
    ;  mov rdi,printf_format
    ;  mov rsi,[rsp+8]
    ;  call printf
    ;  ret
    add rsp, 24
    ret
