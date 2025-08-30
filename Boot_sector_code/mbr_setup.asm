section .text 
global bios_main 
bits 16
bios_main:
    cli
    cld
    mov [boot_drive], dl
    mov ax, 0x7C00
    mov ds, ax
    mov ax, 0x9500
    mov es, ax
    mov cx, 128
    xor si, si
    xor di, di
    rep movsd
    jmp 0x9500:dev
dev:
    mov ax,cs
    mov ds,ax
    mov es,ax
    mov ss,ax
    mov sp,0xFFF0
setup:
    mov dl, [boot_drive]
    mov dh, 0x00 
    mov cx,0x0001
    mov bx,0x0200
    mov ax,0x0208
    mov byte [count], 3
verify_1:
    int 0x13        
    jnc verify_2 
    dec byte [count]
    jz error       
    jmp verify_1
verify_2:
    cmp al, 8       
    jne error     
    jmp 0x9520:0
error:
    jmp $
boot_drive: db 0
count: db 0
db 0x80                   
db 0xFE, 0xFF, 0xFF       
db 0x0C                  
db 0xFE, 0xFF, 0xFF      
dd 9                    
dd 1228800                

db 0x00                   
db 0xFE, 0xFF, 0xFF 
db 0x06                   
db 0xFE, 0xFF, 0xFF 
dd 1228809 
dd 2097152
times 510 - ($ - $$) db 0 
dw 0xAA55