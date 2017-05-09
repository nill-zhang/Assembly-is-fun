
; by sfzhang 2017.5.9
; this program overwrites the 8 data words of the code 
; with data from memory location 0:0h
assume cs: overwrite_codedata

overwrite_codedata segment   
                                                              
          ; 8 data words stored at the beginning of code
          ; they are all identifiable 'AA'                                                  
          dw 4141h,4141h,4141h,4141h,4141h,4141h,4141h,4141h ;
          
    
 start:   mov ax, 0h
          mov ds, ax
          mov bx, 0h      ; set data register and its shifting initial value 
          
                   
          mov cx, 8h      ; loop counter
   init:  mov [bx], 6161h ; words in the souce block are all 'aa'
          add bx, 2
          loop init       ; initialize source block 
          
         
       
          mov cx, 8h      ; reset loop counter
          mov bx, 0h
   redo:  mov ax, [bx]
          mov cs:[bx], ax ; overwrite program data
          add bx, 2       ; copy one word at a time so the shifting is 2-bytes
          loop redo 
            
          
          mov ax, 004ch
          int 21h
          ret
    
overwrite_codedata ends

end start                   