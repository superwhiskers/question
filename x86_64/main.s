; vim: ft=nasm
BITS 64

%include "constants.s"

section .data
	%include "data.s"

section .bss
	%include "bss.s"

section .text
	%include "syscalls.s"
	%include "utilities.s"

global _start
_start:
	util_alloc 13           ; allocate enough space to store message
	mov qword [addr], rax   ; place address into variable
	mov qword [rax], hello  ; place message into allocated memory
	sys_write 1, [addr], 13 ; output message

	mov rax, 60  ; exit()
	mov rdi, 0   ; code: 0
	syscall      ; call

