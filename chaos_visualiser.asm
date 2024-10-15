section .data
    one dq 1.0
    increment dq 0.01 ; Slow down the increase of r
    r dq 3.5

section .bss
    x resq 1          ; Current x value

section .text
global calculate_next_state

calculate_next_state:
    ; RDI contains the pointer to the output buffer

    mov ecx, 25       ; Loop for 25 lines
line_loop:
    push rcx          ; Save the line counter

    mov ecx, 80       ; 80 characters per line
char_loop:
    ; Compute next x value: x = r * x * (1 - x)
    fld qword [r]     ; Load r
    fmul qword [x]    ; r * x
    fld1              ; Load 1
    fsub qword [x]    ; 1 - x
    fmulp st1, st0    ; r * x * (1 - x)
    fstp qword [x]    ; Store result back to x

    ; Convert x to an ASCII symbol (0-7)
    fld qword [x]
    fmul qword [one]  ; Scale to range 0-7
    fisttp qword [x]  ; Convert to integer
    mov rax, [x]
    and rax, 7        ; Ensure the result is between 0 and 7

    add al, ' '       ; Convert to ASCII symbol (' ' to '&')
    mov [rdi], al     ; Store character in the output buffer
    inc rdi

    dec ecx           ; Decrement character counter
    jnz char_loop     ; Loop through 80 characters

    ; Add newline character
    mov byte [rdi], 10
    inc rdi

    pop rcx           ; Restore the line counter
    dec ecx
    jnz line_loop     ; Repeat for 25 lines

    ; Increment r slowly for the next cycle
    fld qword [r]
    fadd qword [increment]
    fstp qword [r]

    ret

