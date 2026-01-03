/*this is a level 1 kernel file to 
1.load logo to display
2.set global descriptor table
3.set interrupt descriptor table
4.set paging and open paging
It's great to write a OS and open source it
*/
#include <stdint.h>
#include <string.h>
#include <stdio.h>
extern void idt_init();
extern void paging_enable();
extern void load_logo();
uint32_t *PG_address = (uint32_t*)0x00100000;
void page_table_init(int x){
    uint32_t *pg_t_address = (uint32_t*)(0x00001000*(x+1)+0x00100000);
    for(int i=0;i<1024;i++){
        pg_t_address[i] = (0x00001000*i+0x00400000*x) | 0x3;
    }
}
void paging_init(){
    for(int i=0;i<1024;i++){
        PG_address[i] = (0x00001000*(i+1)+0x00100000) | 0x3;
        page_table_init(i);
    }
    paging_enable();
}
void main(){
    idt_init();
    paging_init();
    load_logo();
}