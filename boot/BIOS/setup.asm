bits 16
org 0x7C00
section .text
    global _start
_start:
    mov [boot_disk], dl
    mov ax, 0x0003
    int 0x10
    xor ax,ax
    mov ds,ax
    mov ax,0x07c0
    mov es,ax     
    mov ax,0x1301
    mov bx,0x0070
    mov cx,25
    mov dx,0x0100
    mov bp,msg1
    int 0x10
    jnc _move
    call _error
_move:
    mov ax,0x0000
    mov es,ax
    mov dl,[boot_disk]
    mov dh,0x00
    mov ch,0x00
    mov cl,0x02
    mov bx,0x9000
    mov ah,0x02
    mov al,8
    int 0x13
    jnc _jamp
    call _error
_jamp:
    jmp 0x0900:0x0000
_error:
    xor ax,ax
    mov ds,ax
    mov ax,0x07c0
    mov es,ax       
    mov ax,0x1301
    mov bx,0x0040
    mov cx,25
    mov dx,0x0200
    mov bp,msg2
    int 0x10
    jmp $
boot_disk db 0
msg1 db "Loading system...        "
msg2 db "Loading error/failed  !!!"
times 510 - ($ - $$) db 0
dw 0xAA55