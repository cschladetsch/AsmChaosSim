section .data
    one dq 1.0
    r dq 3.5  ; Initial r value

section .bss
    x resq 1   ; Current x value

section .text
global calculate_next_state

calculate_next_state:
    ; RDI contains the pointer to the output buffer
    
    ; Generate 25 lines of 80 characters each
    mov ecx, 25  ; Line counter
line_loop:
    push rcx  ; Save line counter
    
    mov ecx, 80  ; 80 characters per line
char_loop:
    ; Compute next x value: x = r * x * (1 - x)
    fld qword [r]     ; r
    fmul qword [x]    ; r * x
    fld1              ; 1
    fsub qword [x]    ; 1 - x
    fmulp st1, st0    ; r * x * (1 - x)
    fstp qword [x]    ; store result back to x

    ; Convert to ASCII symbol
    fld qword [x]
    fmul qword [one]  ; Scale to 0-7
    fisttp qword [x]  ; Convert to integer
    
    mov rax, [x]
    and rax, 7        ; Ensure it's 0-7
    
    ; Store symbol in output buffer
    add al, ' '       ; Convert to ASCII range ' ' to '&'
    mov [rdi], al
    inc rdi

    dec ecx
    jnz char_loop

    ; Add newline to buffer
    mov byte [rdi], 10  ; Newline character
    inc rdi

    pop rcx  ; Restore line counter
    dec ecx
    jnz line_loop

    ; Increase r parameter
    fld qword [r]
    fld1
    faddp st1, st0
    fmul qword [one]  ; Slow down the increase
    fstp qword [r]

    ret
