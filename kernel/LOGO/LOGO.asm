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
    lea eax,default_int
    mov bx,ax
    shr eax,16
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
idt:
    dd 
    dd 
default_int:
jmp_fun:
    lss esp,[stark_inf]
    ret
stark_inf:
    dd 0XC0000000
    dw 0x0010
    dw 0x0000
times 1048576 - ($ - $$) db 0