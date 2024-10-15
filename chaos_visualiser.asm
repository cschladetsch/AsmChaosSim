section .data
    one dq 1.0
    increment dq 0.01    ; Slow increment of r
    init_x dq 0.5        ; Initial x value
    r dq 3.5             ; Initial r value

section .bss
    x resq 1             ; Current x value

section .text
global calculate_next_state

calculate_next_state:
    ; RDI contains the pointer to the output buffer

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

    ; Make sure x is in the range [0, 1]
    fld qword [rel x]
    fld1
    fsub st0, st1        ; 1 - x (ensures it's between 0 and 1)
    fisttp qword [rel x] ; Convert to integer if needed

    ; Scale x to a better range for ASCII characters (using a broader range)
    mov rax, [rel x]
    and rax, 15          ; Limit value to 0-15 for a wider ASCII range

    ; Convert to an ASCII character
    add al, ' '          ; Map to ASCII range starting from space ' '
    mov [rdi], al        ; Store in output buffer
    inc rdi

    ; Loop for all characters in the line
    dec ecx
    jnz char_loop

    ; Add newline
    mov byte [rdi], 10   ; Newline
    inc rdi

    pop rcx              ; Restore line counter
    dec ecx
    jnz line_loop

    ; Increment r slowly for next cycle
    fld qword [rel r]
    fadd qword [rel increment]
    fstp qword [rel r]

    ret

