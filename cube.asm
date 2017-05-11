
; by sfzhang @2017.5.9
; this program calculate a number's cube 
assume cs: code,ds: data
 
data segment
    
    db 10      ; the number I want to calculate

data ends    

code segment
    
   main: mov ax, data     ; entry point of the program
         mov ds, ax
         
         mov bl, ds:[0]   ; copy the number to bx
         mov bh, 0 
         call cubic       ; calling subroutine
         mov ax, 004ch
         int 21h 
         
  cubic: mov ax, 1        ; result will be stored in register ax
         mov cx, 3       
      m: mul bx      
         loop m
         ret              ; return to the caller
                                             
    
code ends  

end main