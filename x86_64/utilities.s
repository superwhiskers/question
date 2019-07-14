; vim: ft=nasm
BITS 64

; mmap() wrapper to simplify memory allocation
%macro util_alloc 1
sys_mmap 0, %1, MMAP_PROT_READ|MMAP_PROT_WRITE, MMAP_MAP_PRIVATE|MMAP_MAP_ANONYMOUS, -1, 0
%endmacro
