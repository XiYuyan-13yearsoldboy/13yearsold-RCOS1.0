section .text
    global jmp_main
jmp_main:
    call _main
paging_enable:
    mov eax,0x40020000
    mov cr3, eax
    mov eax, cr0
    or eax, 0x80000000
    mov cr0, eax
    ret