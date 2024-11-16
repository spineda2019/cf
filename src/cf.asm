;    cf: count the files in your current directory tree
;    Copyright (C) 2024  Sebastian Pineda
;    
;    This program is free software: you can redistribute it and/or modify
;    it under the terms of the GNU General Public License as published by
;    the Free Software Foundation, either version 3 of the License, or
;    (at your option) any later version.
;    
;    This program is distributed in the hope that it will be useful,
;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;    GNU General Public License for more details.
;    
;    You should have received a copy of the GNU General Public License
;    along with this program.  If not, see <https://www.gnu.org/licenses/>.


section .data
    ; 10 is the ascii num for \n and 0 is the \0 byte
    HELP_MESSAGE db                           \
    "Count the files in your directory tree", \
    10,                                       \
    10,                                       \
    "Usage: cf [-d DIRECTORY]",               \
    10, 0

section .text
    global _start

; The Entry point of our program. Not portalble to anything besides linux
; this is expected to be an ELF format binary (for now)
_start:
    call parse_args
    call help_message

    call exit

; Parse command line args
; Input:
;    RDI - Argc
parse_args:
    push RBP
    mov RBP, RSP

    sub RSP, 8               ; Reserve 8 bytes
    mov byte [RBP], "H"
    mov byte [RBP + 1], "e"
    mov byte [RBP + 2], "l"
    mov byte [RBP + 3], "l"
    mov byte [RBP + 4], "o"
    mov byte [RBP + 5], 10   ; LF byte (\n)
    mov byte [RSP + 6], 0    ; null byte (\0)

    mov RSI, RBP
    mov RDX, 7
    call print

.done_parsing_args:
    mov RSP, RBP
    pop RBP
    ret

help_message:
    mov RSI, HELP_MESSAGE    ; move the string (the address of the first char)
                             ; to the rsi, where write expects the buffer
    mov RDX, 66              ; Size of buffer in RSI to write
    call print

    call exit


; Convenient routine for printing
; Input:
;    RSI - The address of the buffer to be printed
;    RDX - The number of bytes to write to stdout
print:
    push RBP
    mov RBP, RSP
    mov RAX, 1               ; 1 is the syscall code for write
    mov RDI, 2               ; 1 is the file descriptor for stdout
    syscall
    mov RSP, RBP
    pop RBP
    ret

; Convenient routine for exiting the program
; Input:
;    RDI - Exit code to exit with
exit:
    mov RAX, 60              ; 60 is the syscall code for exit
    syscall
