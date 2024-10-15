section .data
    one dq 1.0
    increment dq 0.01    ; Slow increment of r
    init_x dq 0.6        ; Initial x value
    r dq 3.5             ; Initial r value

section .bss
    x resq 1             ; Current x value

section .text
global calculate_next_state

calculate_next_state:
    mov ecx, 25          ; Loop for 25 lines
    mov rax, [rel init_x] ; Load initial x value to register
    mov [rel x], rax     ; Set x to initial value
line_loop:
    push rcx             ; Save the line counter

    mov ecx, 80          ; 80 characters per line
char_loop:
    ; Compute x = r * x * (1 - x)
    fld qword [rel r]    ; Load r using RIP-relative addressing
    fmul qword [rel x]   ; r * x
    fld1                 ; Load 1
    fsub qword [rel x]   ; 1 - x
    fmulp st1, st0       ; r * x * (1 - x)
    fstp qword [rel x]   ; Store the result back to x

    ; Debug: print value of x (scale and map to ASCII '0'-'9')
    fld qword [rel x]
    fmul qword [rel one] ; Scale to 0-9 for easier output
    fisttp qword [rel x] ; Convert to integer
    mov rax, [rel x]
    add al, '0'          ; Convert to ASCII '0'-'9'
    mov [rdi], al        ; Store in output buffer
    inc rdi

    dec ecx
    jnz char_loop

    ; Add newline after each line
    mov byte [rdi], 10   ; Newline
    inc rdi

    pop rcx              ; Restore line counter
    dec ecx
    jnz line_loop

    fld qword [rel r]
    fadd qword [rel increment]
    fstp qword [rel r]

    ret

