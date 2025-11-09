bits 16;实模式
org 0x7C00;0x7c00引导扇区的内存地址
section .text
    global _start
_start:
    mov [boot_disk], dl;保存引导盘号
    mov ax,0x07c0
    mov ds,ax;设置数据段
    mov ax,0x1000
    mov ss,ax
    mov sp,0
    mov ax,0xB800
    push ax
    mov ax,0x7
    push ax
    mov ax,msg1
    push ax
    mov cx,17
    push cx
    call _printf
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
    jmp $
_printf:
    pop di
    mov ax,cx
    pop bx
    sub ax,bx
    pop si
    add si,ax
    mov dh,[si]
    pop bx
    add dx,bx
    shl ax,1
    mov si,ax
    pop bx
    mov es,bx
    mov word [es:si],dx
    loop _printf
    add si,2
    mov word [es:si],0x0A0D
    push di
    ret
boot_disk db 0
msg1 db 'Loading system...'
msg2 db 'Loaded successfully!'
msg3 db 'Load error!!!'
times 0x1B8 - ($ - $$) db 0
db 0x7E,0xDD,0x88,0x91,0x00,0x00,0x00,0x20,0x21,0x00,0x0C,0x1E,0x2B,0x33,0x00,0x08,0x00,0x00,0x00,0x80,0x0C,0x00,0x00,0x00;分区表
times 510 - ($ - $$) db 0
dw 0xAA55