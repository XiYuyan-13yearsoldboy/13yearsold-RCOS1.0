#include <stdint.h>
#include <stdio.h>
struct v_m_i{
    uint16_t mode;
    uint16_t w;
    uint16_t h;
    uint8_t bitcolor;

}video_mode_inf;
void load_logo(){
}
void set_gdt(){
}
void set_idt(){
}
void paging_init(){
}
extern "C" void main(){
    load_logo();
    set_gdt();
    set_idt();
    paging_init();
}