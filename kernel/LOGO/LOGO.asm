section .text
    global jmp_main
jmp_main:
    call _main
gdt_init:
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

    dd 0xC0000000
    dd 0x00C09A00

    dd 0x00000000
    dd 0x70C09200

    dd 0x00000000
    dd 0xF0C09200