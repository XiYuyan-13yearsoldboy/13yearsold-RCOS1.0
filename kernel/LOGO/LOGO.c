/*this is a level 1 kernel file to 
1.load logo to display
2.set global descriptor table
3.set interrupt descriptor table
4.set paging and open paging
It's great to write a OS and open source it
*/
#include <stdint.h>
#include <stdio.h>
uint32_t *address = (uint32_t*)0x4004F000;
struct v_m_i{
    uint16_t mode;
    uint16_t w;
    uint16_t h;
    uint8_t bitcolor;
}video_mode_inf;
void page_table_init(int x){
    uint32_t *pg_t_address = (uint32_t*)((x+1)*4*1024+0x4004F000);
    for(int i=0;i<1024;i++){
        pg_t_address[i] = (0x00001000*i+0x10000000*x) | 0x3;
    }
}
void load_logo(){
}
void set_gdt(){
}
void set_idt(){
}
void paging_init(){
    for(int i=0;i<1024;i++){
        address[i] = (0x00001000*(i+1)) | 0x3;
    } //set page directory table
    for(int i=0;i<1024;i++){
        page_table_init(i);
    }
    extern void paging_enable();
}
void main(){
    asm ("movl $0xA0000000, %esp");
    load_logo();
    set_gdt();
    set_idt();
    paging_init();
}