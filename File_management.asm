SECTION .data
    filename    db 'quotes.txt', 0
    quote1      db 'To be, or not to be, that is the question.', 0xA
    q1_len      equ $ - quote1
    quote2      db 'A fool thinks himself to be wise, but a wise man knows himself to be a fool.', 0xA
    q2_len      equ $ - quote2
    quote3      db 'Better three hours too soon than a minute too late.', 0xA
    q3_len      equ $ - quote3
    quote4      db 'No legacy is so rich as honesty.', 0xA
    q4_len      equ $ - quote4

SECTION .bss
    fd_out      resd 1

SECTION .text
    global _start

_start:
    ; Create quotes.txt
    mov eax, 8              ; sys_creat
    mov ebx, filename
    mov ecx, 0777o
    int 0x80
    mov [fd_out], eax

    ; Write first quote
    mov eax, 4              ; sys_write
    mov ebx, [fd_out]
    mov ecx, quote1
    mov edx, q1_len
    int 0x80

    ; Write second quote
    mov eax, 4
    mov ebx, [fd_out]
    mov ecx, quote2
    mov edx, q2_len
    int 0x80

    ; Close file
    mov eax, 6
    mov ebx, [fd_out]
    int 0x80

    ; Reopen file for writing/appending
    mov eax, 5              ; sys_open
    mov ebx, filename
    mov ecx, 1              ; write-only
    mov edx, 0777o
    int 0x80
    mov [fd_out], eax

    ; Seek to end for appending
    mov eax, 19             ; sys_lseek
    mov ebx, [fd_out]
    mov ecx, 0              ; offset = 0
    mov edx, 2              ; SEEK_END
    int 0x80

    ; Write third quote
    mov eax, 4
    mov ebx, [fd_out]
    mov ecx, quote3
    mov edx, q3_len
    int 0x80

    ; Write fourth quote
    mov eax, 4
    mov ebx, [fd_out]
    mov ecx, quote4
    mov edx, q4_len
    int 0x80

    ; Close file
    mov eax, 6
    mov ebx, [fd_out]
    int 0x80

    ; Exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80
