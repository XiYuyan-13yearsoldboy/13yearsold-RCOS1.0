bits 32
section .text
    global jmp_main
    extern _main
jmp_main:
    lss esp,[stark_inf]
    call _main
_DE:            
_DB:
_NMI:
_BP:
_OF:
_BR:
_UD:
_NM:
_DF:
_TS:
_NP:
_SS:
_GP:
_PF:
_MF:
_AC:
_MC:
_XM:
_VE:
_CP:
_HARDDISK:
_VIDEO:
_KEYBOARD:
idt_init:
    lea eax,_DE
    add eax,0x8000
    mov word [0x2000],ax
    mov word [0x2002],0x10
    shr eax,16
    mov word [0x2004],0x8E00
    mov word [0x2006],ax

    lea eax,_DB
    add eax,0x8000
    mov word [0x2008],ax
    mov word [0x200A],0x10
    shr eax,16
    mov word [0x200C],0x8E00
    mov word [0x200E],ax

    lea eax,_NMI
    add eax,0x8000
    mov word [0x2010],ax
    mov word [0x2012],0x10
    shr eax,16
    mov word [0x2014],0x8E00
    mov word [0x2016],ax

    lea eax,_BP
    add eax,0x8000
    mov word [0x2018],ax
    mov word [0x201A],0x10
    shr eax,16
    mov word [0x201C],0x8E00
    mov word [0x201E],ax

    lea eax,_OF
    add eax,0x8000
    mov word [0x2020],ax
    mov word [0x2022],0x10
    shr eax,16
    mov word [0x2024],0x8E00
    mov word [0x2026],ax

    lea eax,_BR
    add eax,0x8000
    mov word [0x2028],ax
    mov word [0x202A],0x10
    shr eax,16
    mov word [0x202C],0x8E00
    mov word [0x202E],ax

    lea eax,_UD
    add eax,0x8000
    mov word [0x2030],ax
    mov word [0x2032],0x10
    shr eax,16
    mov word [0x2034],0x8E00
    mov word [0x2036],ax

    lea eax,_NM
    add eax,0x8000
    mov word [0x2038],ax
    mov word [0x203A],0x10
    shr eax,16
    mov word [0x203C],0x8E00
    mov word [0x203E],ax

    lea eax,_DF
    add eax,0x8000
    mov word [0x2040],ax
    mov word [0x2042],0x10
    shr eax,16
    mov word [0x2044],0x8E00
    mov word [0x2046],ax

    mov dword [0x2048],0x00000000
    mov dword [0x204C],0x00000000

    lea eax,_TS
    add eax,0x8000
    mov word [0x2050],ax
    mov word [0x2052],0x10
    shr eax,16
    mov word [0x2054],0x8E00
    mov word [0x2056],ax

    lea eax,_NP
    add eax,0x8000
    mov word [0x2058],ax
    mov word [0x205A],0x10
    shr eax,16
    mov word [0x205C],0x8E00
    mov word [0x205E],ax

    lea eax,_SS
    add eax,0x8000
    mov word [0x2060],ax
    mov word [0x2062],0x10
    shr eax,16
    mov word [0x2064],0x8E00
    mov word [0x2066],ax

    lea eax,_GP
    add eax,0x8000
    mov word [0x2068],ax
    mov word [0x206A],0x10
    shr eax,16
    mov word [0x206C],0x8E00
    mov word [0x206E],ax

    lea eax,_PF
    add eax,0x8000
    mov word [0x2070],ax
    mov word [0x2072],0x10
    shr eax,16
    mov word [0x2074],0x8E00
    mov word [0x2076],ax

    mov dword [0x2078],0x00000000
    mov dword [0x207A],0x00000000

    lea eax,_MF
    add eax,0x8000
    mov word [0x207C],ax
    mov word [0x207E],0x10
    shr eax,16
    mov word [0x2080],0x8E00
    mov word [0x2082],ax

    lea eax,_AC
    add eax,0x8000
    mov word [0x2084],ax
    mov word [0x2086],0x10
    shr eax,16
    mov word [0x2088],0x8E00
    mov word [0x208A],ax

    lea eax,_MC
    add eax,0x8000
    mov word [0x208C],ax
    mov word [0x208E],0x10
    shr eax,16
    mov word [0x2090],0x8E00
    mov word [0x2092],ax

    lea eax,_XM
    add eax,0x8000
    mov word [0x2094],ax
    mov word [0x2096],0x10
    shr eax,16
    mov word [0x2098],0x8E00
    mov word [0x209A],ax

    lea eax,_VE
    add eax,0x8000
    mov word [0x209C],ax
    mov word [0x209E],0x10
    shr eax,16
    mov word [0x20A0],0x8E00
    mov word [0x20A2],ax

    lea eax,_CP
    add eax,0x8000
    mov word [0x20A4],ax
    mov word [0x20A6],0x10
    shr eax,16
    mov word [0x20A8],0x8E00
    mov word [0x20AA],ax
    lidt [idtr_inf]
    ret
paging_enable:
    mov eax,0x00100000
    mov cr3, eax
    mov eax, cr0
    or eax, 0x80000000
    mov cr0, eax
    ret
idtr_inf:
    dw 0x07FF
    dd 0x00002000
stark_inf:
    dd 0x10
    dd 0XA0000000
times 8192 - ($ - $$) db 0