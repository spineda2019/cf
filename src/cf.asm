;    cf: count the files in your current directory tree
;    Copyright (C) <year>  <name of author>
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

_start:
    mov RAX, [rsp]           ; The first thing on the stack
                             ; (where rsp initially points) should be argc, the
                             ; arg count

    mov RBX, [rsp + 8]       ; Second value on the stack will be argv
                             ; argv is a char**, all contiguous

    call parse_args
    call help_message

; Parse command line args
; Input:
;    RAX - address of Argc
;    RBX - address of Argv
parse_args:
    mov RSI, RAX
    mov RDX, 8
    call print

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
    mov RAX, 1               ; 1 is the syscall code for write
    mov RDI, 2               ; 1 is the file descriptor for stdout
    syscall

; Convenient routine for exiting the program
; Input:
;    RDI - Exit code to exit with
exit:
    mov RAX, 60              ; 60 is the syscall code for exit
    syscall
