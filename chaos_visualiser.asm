; Chaos Visualiser
; A program that generates an ASCII animation of the logistic map's chaotic behavior
section .data
    debug_msg db "Debug: Iteration ", 0
    debug_msg_len equ $ - debug_msg
    newline db 10
    symbols db " .:;+=xX$&"
    one dd 1.0
    r dd 3.75  ; Initial r value

section .bss
    x resd 1   ; Current x value
    debug_num resb 16

section .text
global _start

_start:
    ; Initialize x
    fld dword [one]
    fmul dword [one]
    fstp dword [x]

    ; Main loop
    mov ecx, 10  ; Reduced number of iterations for debugging
main_loop:
    push ecx  ; Save loop counter

    ; Print debug message
    mov eax, 4
    mov ebx, 1
    mov ecx, debug_msg
    mov edx, debug_msg_len
    int 0x80

    ; Print iteration number
    mov eax, 10
    sub eax, ecx
    add eax, '0'  ; Convert to ASCII
    mov [debug_num], al
    mov eax, 4
    mov ebx, 1
    mov ecx, debug_num
    mov edx, 1
    int 0x80

    ; Print newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Generate and print 5 lines of 20 characters each (reduced for debugging)
    mov ecx, 5  ; Line counter
line_loop:
    push ecx  ; Save line counter
    
    mov ecx, 20  ; 20 characters per line
char_loop:
    ; Compute next x value: x = r * x * (1 - x)
    fld dword [r]     ; r
    fmul dword [x]    ; r * x
    fld dword [one]   ; 1
    fsub dword [x]    ; 1 - x
    fmulp st1, st0    ; r * x * (1 - x)
    fstp dword [x]    ; store result back to x

    ; Convert to ASCII symbol and print
    fld dword [x]
    fmul dword [one]  ; Scale to 0-8
    fisttp dword [x]  ; Convert to integer
    
    mov eax, [x]
    and eax, 7        ; Ensure it's 0-7
    
    ; Print symbol
    mov edx, 1
    mov ecx, symbols
    add ecx, eax
    push eax
    mov eax, 4
    mov ebx, 1
    int 0x80
    pop eax
    
    loop char_loop

    ; Print newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    pop ecx  ; Restore line counter
    dec ecx
    jnz line_loop

    ; Increase r parameter
    fld dword [r]
    fadd dword [one]
    fmul dword [one]  ; Slow down the increase
    fstp dword [r]
    
    ; Delay
    mov eax, 162
    mov ebx, 500  ; Increased delay for debugging
    xor ecx, ecx
    int 0x80  ; nanosleep syscall
    
    pop ecx  ; Restore main loop counter
    dec ecx
    jnz main_loop

    ; Exit
    mov eax, 1
    xor ebx, ebx
    int 0x80
