section .text
    global jmp_main
jmp_main:
    call _main
gdt_init:
    mov edi, 0x1000 
    mov esi, gdt
    mov ecx, (gdt_end - gdt)/4 
    rep movsd
    lgdt [gdtr_inf]
    ret
paging_enable:
    mov eax,0x4004F000
    mov cr3, eax
    mov eax, cr0
    or eax, 0x80000000
    mov cr0, eax
    ret
gdtr_inf:
    dw 0xFF
    dd 0x00001000
gdt:
    dd 0x00000000
    dd 0x00000000

    dd 0x0000FFFF
    dd 0x00CF9A00

    dd 0x0000FFFF
    dd 0x00CF9200
gdt_end: