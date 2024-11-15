section .data
    SUCCESS db 0

section .text
    global _start

_start:
    mov RAX, 60         ; 60 is the syscall code for exit
    mov RDI, SUCCESS    ; exit with exit code 0
    syscall
