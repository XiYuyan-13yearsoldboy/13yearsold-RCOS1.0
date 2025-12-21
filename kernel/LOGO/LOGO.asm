bits 32
section .text
    global jmp_main
    extern _main
jmp_main:
    call _main
    lss esp,[stark_inf]
idt_init:  
paging_enable:
    mov eax,0x00100000
    mov cr3, eax
    mov eax, cr0
    or eax, 0x80000000
    mov cr0, eax
    ret
load_logo:
    ret
idtr_inf:
    dw 0x07FF
    dd 0x00007000
stark_inf:
    dd 0x10
    dd 0XA0000000
times 1048576 - ($ - $$) db 0