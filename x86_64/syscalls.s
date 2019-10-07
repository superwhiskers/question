; vim: ft=nasm
BITS 64

; write(fd, buf, count)
%macro sys_write 3
mov rax, 1  ; write()
mov rdi, %1 ; fd
mov rsi, %2 ; buf
mov rdx, %3 ; count
syscall     ; execute
%endmacro

; read(fd, buf, count)
%macro sys_read 3
mov rax, 0  ; read()
mov rdi, %1 ; fd
mov rsi, %2 ; buf
mov rdx, %3 ; count
syscall     ; execute
%endmacro

; mmap(addr, length, prot, flags, fd, offset)
%macro sys_mmap 6
mov rax, 9  ; mmap()
mov rdi, %1 ; addr
mov rsi, %2 ; length
mov rdx, %3 ; prot
mov r10, %4 ; flags
mov r8,  %5 ; fd
mov r9,  %6 ; offset
syscall     ; execute
%endmacro

; TODO: fix
; munmap() system call macro
;.macro sys_munmap addr 
