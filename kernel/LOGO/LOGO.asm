section .text
    global jmp_main
jmp_main:
    call _main
gdt_init: 
    mov eax,0x00001000
    mov dword [eax],0x00000000
    mov dword [eax+4],0x00000000
    mov dword [eax+8],0x0000FFFF
    mov dword [eax+12],0x00CF9A00
    mov dword [eax+16],0x0000FFFF
    mov dword [eax+20],0x00CF9200
    lgdt [gdtr_inf]
    ret
idt_init:
    mov eax,0x00007000
    mov cx,256
    lidt [idtr_inf]
    ret
paging_enable:
    mov eax,0x4004F000
    mov cr3, eax
    mov eax, cr0
    or eax, 0x80000000
    mov cr0, eax
    ret
gdtr_inf:
    dw 0x00FF
    dd 0x00001000
idtr_inf:
    dw 0x07FF
    dd 0x00007000
jmp_fun:
    lss esp,0xC0000000
    push _kernel_main
    ret