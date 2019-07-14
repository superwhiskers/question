; vim: ft=nasm
BITS 64

; mmap constants
%define MMAP_PROT_READ     0x1
%define MMAP_PROT_WRITE    0x2
%define MMAP_MAP_PRIVATE   0x2
%define MMAP_MAP_ANONYMOUS 0x20
