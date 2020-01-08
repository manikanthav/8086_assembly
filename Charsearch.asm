; $Header: $ To search a character in a given string.
;
; $Description: $ Here iam finding the length of the string and then comparing\
;  the given character with each character of given string until the end of   \
;  the string (Length=0). 
;
;-----------------------------------------------------------------------------
;-----------------------------------------------------------------------------
.model small                            ; Program uses a maximum 64 KB of   \
                                        ;memory for code
.stack                                  ; Begining of stack space
;------------------------------------------------------------------------------
;                                     DATA SEGMENT
;------------------------------------------------------------------------------
.data                                   ; Begining of data segment where    \
data1 db 20 dup('$')                    ;variable are stored		
msg2 db 10,13,"found",'$'               ; Variables to use in code
msg3 db 10,13,"not found",'$'
;-------------------------------------------------------------------------------
;                                    DATA SEGMENT ENDS
;-------------------------------------------------------------------------------			
;-------------------------------------------------------------------------------
;                                     CODE SEGMENT
;-------------------------------------------------------------------------------
.code                                   ; Begining of code segment all       \
                                        ; executable part is here
start:
        mov     ax, @DATA               ; Make AX pionting to data segment
        mov     ds, ax                  ; Initializing data segment where    \
                                        ; variable are declared
        mov     es, ax                  ; Initializing extra segment 
        mov     ah, 3fh					
        mov     dx, offset data1        ; Interrupt to read set of characters\ 
        int     21h                     ; from the user					
        lea     dx, data1				
        mov     ah, 09h                 ; Interrupt to print the string
        int     21h						
        mov     ah, 01h                 ; Interrupt to read byte from user
        int     21h		
        lea     di, data1               ; Loading string to di register to  \
                                        ; transeverse along the string
        mov     cx, 0000h	              ; Initializing count to zero
        cld                             ; To transevers from left to right
length1:                                ; Label to find the length of string
        mov     bx, [di]                ; Copy each word of data to bx register
        cmp     bl, '$'                 ; Compare each byte with Null character
        jz      search                  ; It is end of string go to search label
        inc     cx                      ; Incrementing count
        inc     di                      ; Incrrementing destination index
        jmp     length1                 ; Go to length to form loop
search:									
        lea     di, data1               ; Again loading the string to DI
        repne   scasb                   ; Repeat the same instruction until \
                                        ; either cx!=0,zf=0
        jz      found                   ; Go to found when zero flag set
        jnz     notfound                ; Go to notfound when zero flag is cleared
found:									
        lea     dx, msg2                ; Interrupt to display the found string
        mov     ah, 09h					
        int     21h						
        mov     ah, 4ch                 ; Interrupt to exit
        int     21h			 			
notfound:								
        lea     dx, msg3					
        mov     ah, 09h                 ; Interrupt to display notfound string
        int     21h						
        mov     ah, 4ch                 ; Interrupt to exit
        int     21h						
end start
end			
