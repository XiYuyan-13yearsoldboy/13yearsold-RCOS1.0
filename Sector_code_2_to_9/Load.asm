section .text
    global setting
setting:
    mov [boot_drive], dl
    mov ax,0x94E0
    mov ds, ax
    jmp memory_inf
memory_inf:
    mov ah,0x88
    int 0x15
    mov [0],ax
    jnc video_card_inf
    jmp memory_inf
video_card_inf:
    mov ah,0x0f
    int 0x10
    mov [2],bx
    mov [4],al
    mov [5],ah
    jnc vd_mode_inf
    jmp video_card_inf
vd_mode_inf:
    mov ah,0x12
    mov bl,0x10
    int 0x10
    mov [6],ax
    mov [8],bx
    mov [10],cx
    jnc cursor_inf
    jmp vd_mode_inf
cursor_inf: 
    mov ah,0x03
    xor bh, bh
    int 0x10
    mov [12],dx
    jnc hd_fir_inf
    jmp cursor_inf
hd_fir_inf:
    mov ax,0x0000
    mov ds,ax
    lds si,[4*0x41]
    mov ax,0x94E0
    mov es,ax
    xor di, di
    mov cx,4
    rep movsd
    jnc hd_sec_inf
    jmp hd_fir_inf
hd_sec_inf:
    mov ax,0x0000
    mov ds,ax
    lds si,[4*0x46]
    mov ax,0x94E0
    mov es,ax
    xor di, di
    mov cx,4
    rep movsd
    jnc domove
    jmp hd_sec_inf
domove:
    cli
    cld
    mov ax,0x1000
    mov ds,ax
    mov ax,0x0000
    mov es,ax
    xor si, si
    xor di, di
    mov cx, 128
    rep movsd 
.16to32:
    lidt [idt_inf]
    lgdt [gdt_inf]
    mov al,0xD1
    out 0x64,al
    mov al,0xDF
    out 0x60,al
    mov ax,0x0001       
    lmsw ax       
    jmp dword 0x0008:0x12C000
gdt:
    dd 0, 0
    dw 0xFFFF      
    dw 0x0000       
    db 0x00        
    db 0x9A        
    db 0xCF        
    db 0x00        
    dw 0xFFFF      
    dw 0x0000      
    db 0x00        
    db 0x92    
    db 0xCF   
    db 0x00     
gdt_end:
idt_inf:
    dw 0
    dw 0,0
gdt_inf:
    dw 0x800
    dw 512+gdt,0x9
boot_drive: db 0
times 4096 - ($ - $$) db 0