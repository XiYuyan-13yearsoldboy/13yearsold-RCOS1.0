section .text
    global setting
setting:
    mov [boot_drive], dl 
    mov ax,0x0800
    mov ds, ax 
    jmp memory_inf
init_vbe:
    pusha 
    push ds 
    push es 
    mov ax, 0x0300       
    mov es, ax 
    xor di, di          
    mov ax, 0x4F00
    int 0x10
    cmp ax, 0x004F  
    jne .vbe_error
    mov ax, [es:0x04]  
    cmp ax, 0x0200 
    jb .vbe_error
    mov si, [es:0x0E]  
    mov ax, [es:0x10] 
    mov ds, ax         
    mov ax, 0x0320     
    mov es, ax
    xor di, di       
.search_mode:
    lodsw          
    mov cx, ax
    cmp cx, 0xFFFF       
    je .end_search
    mov ax, 0x4F01 
    int 0x10
    cmp ax, 0x004F
    jne .next_mode 
    test word [es:0x00], 0x0081  
    jz .next_mode
    cmp word [es:0x12], 1024  
    jne .next_mode 
    cmp word [es:0x14], 768   
    jne .next_mode 
    cmp byte [es:0x19], 32 
    jne .next_mode 
    mov bx, cx
    or bx, 0x4000         
    mov ax, 0x4F02 
    int 0x10
    cmp ax, 0x004F 
    je .vbe_success 
.next_mode:
    jmp .search_mode 
.end_search:
    mov ax, 0x0003   
    int 0x10
    jmp .vbe_exit 
.vbe_error:
    jmp .vbe_exit 
.vbe_success:
    mov ax, 0x0330
    mov ds, ax 
    mov [0x00], cx 
    mov eax, [es:0x28]  
    mov [0x04], eax 
.vbe_exit:
    pop es
    pop ds
    popa
    ret 
hd_kernel_move:
    mov di, 16384          
    mov word [dap_seg], 0x1000  
    mov dword [dap_lba], 1228801
    mov dword [dap_lba+4], 0 
move_loop:
    call move      
    jc move_loop            
    add word [dap_seg], 0x1000  
    add dword [dap_lba], 128    
    adc dword [dap_lba+4], 0    
    dec di
    jnz move_loop      
    ret 
move:
    mov si, dap          
    mov ah, 0x42        
    mov dl, [boot_drive] 
    int 0x13                    
    ret 
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
    mov ax,0x8000 
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
    mov ax,0x8000
    mov es,ax
    xor di, di
    mov cx,4
    rep movsd 
    call init_vbe
    call hd_kernel_move      
    jnc .16to32 
    jmp hd_sec_inf  
.16to32:
    lidt [idtr_i]
    lgdt [gdtr_i]
    mov al,0xD1
    out 0x64,al 
    mov al,0xDF 
    out 0x60,al
    mov ax,0x0001       
    lmsw ax       
    jmp dword 0x0008:0x10000
vbe_controller_info equ 0x3000
vbe_mode_info       equ 0x3200
vbe_selected_mode   equ 0x3300
dap:
    db 0x10        
    db 0          
    dap_count: dw 128  
    dap_offset: dw 0    
    dap_seg:    dw 0  
    dap_lba:    dq 0
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
idtr_i:
    dw 0 
    dw 0,0
gdtr_i:
    dw 0x800
    dw 512+gdt,0x9 
boot_drive: db 0 