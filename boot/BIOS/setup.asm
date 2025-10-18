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
    mov es, ax           
    mov ax,0x1301
    mov bx,0x0007
    mov cx,len1
    mov dx,0x0000
    mov bp,msg1
    int 0x10
    jnc _move
    call _error
_move:
    mov ax,0x0900
    mov es,ax
    mov dl,[boot_disk]
    mov dh,0x00
    mov cx,0x0002
    mov bx,0x0000
    mov ax,0x0208
    int 0x13
    jmp 0x0900:0x0000
_error:
    mov ax,0x0003
    int 0x10
    xor ax,ax
    mov ds,ax
    mov es, ax            
    mov ax,0x1301
    mov bx,0x0007
    mov cx,len2
    mov dx,0x0000
    mov bp,msg2
    int 0x10
    jmp $
boot_disk db 0
msg1 db "Loading system...",0
len1 equ ($ - msg1) - 1
msg2 db "Loading error/failed ! ! !",0
len2 equ ($ - msg2) - 1
times 510 - ($ - $$) db 0
dw 0xAA55