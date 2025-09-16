**RCOS1.0操作系统简介**
---
# 开发者
> "我是一名来自中国四线城市的13岁操作系统开发者。虽然父母未受过高等教育，但这从未限制我的求知欲——**凭借强大的自学能力和对系统底层的热爱，我正独立构建完整的操作系统**"
# 项目介绍
这是我开发的第一个操作系统，名为RCOS1.0，架构打算采用为 _IA-32_。启动方式打算采取 _BIOS/UEFI_双启动,_BIOS_ 用 _asm_ 实现，_UEFI_ 用 _EDK2_ 实现。整个操作系统基本使用 _asm_ 和 _C/C++_ 实现。
# 项目进程
正在开发，约7~14天更新仓库
## 目前项目流程
红色代表正在进行/修改的项目，绿色代表已完成项目,蓝色代表暂缓
```mermaid
graph LR 
A[引导层] --> B[BIOS/实模式]
A --> C[UEFI/保护模式]
B --> D[ASM引导扇区LBA0]
D --> G[拓展引导扇区LBA1~8，进入保护模式]
C --> E[EDK2固件]
E --> F[内核层]
G --> F
H[内核层] --> I[加载LOGO，重新设置GDT,IDT,开启分页] 
style G fill:#FF4136,stroke:#000;
style I fill:#FF4136,stroke:#000;
style E fill:#1DAFE4,stroke:#000;
style G fill:#0F0,stroke:#000;
style B fill:#0F0,stroke:#000;
style D fill:#0F0,stroke:#000;
```
# 希望
大家可以能为我指出问题，联系方式见下
## 联系方式
anan3055@163.com
