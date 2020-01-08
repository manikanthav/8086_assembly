; $Header: $ To reverse a given string.
;
; $Description: $ Here make si pointing to string1 and transverse until the \
;  end of the string and make di pointing to string2 now copy the characters\
;  from the end of the string1 to starting of the string2 by incrementing si\
;  and decrementing di.
;
;-----------------------------------------------------------------------------
;-----------------------------------------------------------------------------
.model small                            ; Program uses a maximum 64 KB of   \
                                        ; memory for code
.stack                                  ; Begining of stack
;--------------------------------------------------------------------------------
;                                      DATA SEGMENT
;--------------------------------------------------------------------------------
.data                                   ; Begining of data segment where    \
msg db 30 dup('$')                      ; variable are stored
msg2 db 30 dup('$')                     ; Variables to use in this code
msg1 db "Enter the string  ",'$'
;------------------------------------------------------------------------------
;                                     DATA SEGMENT ENDS
;------------------------------------------------------------------------------
;---------------------------------------------------------------------------------
;                                      CODE SEGMENT
;---------------------------------------------------------------------------------
.code                                   ; Begining of code segment all      \
start:                                  ; executable part is here
        mov     ax, @data 
        mov     ds, ax                  ; Initialization of data segment where\
                                        ; variables are stored
        mov     es, ax                  ; Initialization of extra segment
        mov     ah, 09h
        mov     dx, offset msg1
        int     21h                     ; Interrupt to print message
        mov     ah, 3fh
        mov     dx, offset msg
        int     21h                     ; Interrupt to get string from user
        mov     si, offset msg          ; Making si pointing to msg
        mov     cx, 0000h
loop2:                                  ; Label to find the length of string
        mov     ax, [si]							
        cmp     al, '$'                 ; Counting length until end of the string
        jz      reverse                 ; It is end of the string jump to reverse
        inc     si                      ; Changing the pointing of si to next 
        inc     cx                      ; Incrementinting count for each byte
        jmp     loop2
reverse:                                ; Label to reverse the string
        mov     di, offset msg2         ; Making di pointing to msg2
        dec     si                      ; Making si to point end character
loop1:                                  ; Loop to reverse the string 
        cmp     cx, 0
        jz      exit                    ; If the length is zero jump to exit
        mov     dx, [si]                ; Copying each character to msg2
        mov     [di], dx							
        inc     di
        dec     si
        dec     cx
        jmp     loop1                   ; Loop continuos until length is zero
exit:
        mov     dl, '$'                 ; Adding '$' at the end of string
        mov     [di], dx
        lea     dx, msg2
        mov     ah, 09h
        int     21h                     ; Interrupt to print the string
        mov     ah, 4ch
        int     21h                     ; Interrupt to exit
end start
end
;---------------------------------------------------------------------------------
;                                      CODE SEGMENT ENDS
;---------------------------------------------------------------------------------
