bits 32
section .text
    global jmp_main
    extern _main
jmp_main:
    call _main
    lss esp,[stark_inf]
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
    mov [bx_str],bx
    mov [ax_str],ax
    mov cx,256
    call set_idt
    lidt [idtr_inf]
    ret
paging_enable:
    mov eax,0x00100000
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
set_idt:
    
    loop set_idt
    ret
idt:
    bx_str dw 0x0000
    dw 0x0008
    ax_str dw 0x0000
    dw 0x8E00
default_int:
    nop
    iret
stark_inf:
    dd 0XC0000000
    dw 0x0010
    dw 0x0000
times 1048576 - ($ - $$) db 0