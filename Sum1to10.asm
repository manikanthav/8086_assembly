;ALP to sum numbers from 1 to 10 and display the result on screen.
;******************************************************************************
;******************************************************************************
;**                                                                          **
;**             (C)Copyright 1985-2008, American Megatrends, Inc.            **
;**                                                                          **
;**                          All Rights Reserved.                            **
;**                                                                          **
;**                 5555 Oakbrook Pkwy, Norcross, GA 30093    	             **
;**                                                                          **
;**                          Phone (770)-246-8600                            **
;**                                                                          **
;******************************************************************************
;******************************************************************************
.model small                            ; Program uses a maximum 64 KB of   \
                                        ;memory for code
.stack                                  ; Begining of stack space
;-----------------------------------------------------------------------------
;                                     DATA SEGMENT
;-----------------------------------------------------------------------------
.data                                   ; Begining of data segment where    \
                                        ;variable are stored
msg db "sum of 1 to 10 ",'$'            ; Declaring variables to use 
;-----------------------------------------------------------------------------
;                                     CODE SEGMENT
;-----------------------------------------------------------------------------
.code                                   ; Begining of code segment all      \
                                        ;executable part is here
start:
        mov     ax, @data               ; Make AX pointing to data segment
        mov     ds, ax                  ; Initialize data segment where     \
                                        ;variable are declared
        mov     cx, 0000h               ; Moving 0 to cx to start sum from 1
        mov     bx, 000ah               ; Moving a to bx to end summation at 10
adding:                                 ; Label to repeat the summation
        add     cx, bx                  ; adding cx and Bx and storing the  \
        dec     bx                      ;result in cx
        jnz     adding                  ; Loop continuos until bx!=0
        lea     dx, msg					
        mov     ah, 09h                 ; Interrupt to print the message string
        int     21h
        mov     ax, cx                  ; moving the result to ax register to print
        push    ax                      ; push the value of ax to stack to  \
                                        ;prevent loss of data when shifting
        mov     cl, 4                   ; moving 4 to cl register to use it 
                                        ;in shr instruction
        shr     al, cl                  ; shifting the al register by 4 times
        call    printnum                ; calling printnum 
        pop     ax                      ; restoring the value into ax register
        and     al, 0fh                 ; Performing AND with 0F to send the\
                                        ;lower nibble to print
        call    printnum                ; calling printnum
        mov     ah, 4ch
        int     21h                     ; Interrupt to exit
printnum:                               ; Printnum procedure to convert asci\ 
        add     al, 30h                 ;to number
        cmp     al, 39h					
        jle     printhex                ; if it is less than 9 then    
        add     al, 7h                  ; If it is greater than 9 adding extra\ 
                                        ;7 to convert it into alphabet
printhex:                              
        mov     dl, al
        mov     ah, 2h                  ; interrupt to print character
        int     21h
        ret
end start
end
;------------------------------------------------------------------------------
;******************************************************************************
;******************************************************************************
;**                                                                          **
;**             (C)Copyright 1985-2008, American Megatrends, Inc.            **
;**                                                                          **
;**                          All Rights Reserved.                            **
;**                                                                          **
;**                 5555 Oakbrook Pkwy, Norcross, GA 30093    	             **
;**                                                                          **
;**                          Phone (770)-246-8600                            **
;**                                                                          **
;******************************************************************************
;******************************************************************************