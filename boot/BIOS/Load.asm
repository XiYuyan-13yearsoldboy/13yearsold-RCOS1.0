bits 16
section .text
    global setting
gdt_init: 
    mov ax,0x1000
    mov cs,ax
    mov dword [cs:0],0x00000000
    mov dword [cs:4],0x00000000
    mov dword [cs:8],0x0000FFFF
    mov dword [cs:12],0x00CF9A00
    mov dword [cs:16],0x0000FFFF
    mov dword [cs:20],0x00CF9200
    lgdt [gdtr_inf]
    ret
gdtr_inf:
    dw 0x00FF
    dd 0x00001000