; vim: ft=nasm
BITS 64

%include "constants.s"

section .data
	%include "data.s"

section .text
	%include "syscalls.s"
	%include "utilities.s"

global _start
_start:
	sys_write 1, hello, 13

	util_alloc 1        ; test: allocate a single byte
	sys_write 1, rax, 8 ; output address

	mov rax, 60 ; exit()
	mov rdi, 0  ; code: 0
	syscall      ; call

