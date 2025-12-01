org 0x4000
bits 16
section .text
    global setup
setup:
    mov ax,0x0000
    mov ds,ax
    mov ax,0xB828
    mov es,ax
    mov si,msg1
    xor di,di
    mov cx,24
    rep movsw
move:
    mov ax,0x0000
    mov es,ax
    mov dx,0x0080
    mov cx,0x0009
    mov bx,0x8000
    mov ax,0x0240
    int 0x13
get_inf:
    mov si,0x3000
    mov ah,0x0F
    int 0x10
    mov [si],al

gdt_init: 
    mov ax,0x1000
    mov cs,ax
    mov dword [cs:0],0x00000000
    mov dword [cs:4],0x00000000
    mov dword [cs:8],0x0000FFFF
    mov dword [cs:12],0x00CF9A00
    mov dword [cs:16],0x0000FFFF
    mov dword [cs:20],0x00CF9200
    lgdt [gdtr_inf]
    ret
gdtr_inf:
    dw 0x00FF
    dd 0x00001000
msg1:
    db 'G',0x07,'e',0x07,'t',0x07,' ',0x07,'i',0x07,'n',0x07,'f',0x07,'o',0x07,'r',0x07,'m',0x07,'a',0x07,'t',0x07,'i',0x07,'o',0x07,'n',0x07,' ',0x07,'a',0x07,'n',0x07,'d',0x07,' ',0x07,'L',0x07,'o',0x07,'a',0x07,'d',0x07