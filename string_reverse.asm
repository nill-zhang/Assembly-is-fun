
; by sfzhang @2017.5.9
; this program reverse a string in-place 
assume cs: copy,ds: data, ss: statck 
 
data segment
    
    db 'sfZHANGisAgoodGuy!'      ; a 18 byte string

data ends


stack segment

    dw 0,0,0,0,0,0,0,0,0,0        ; stack

stack ends    


code segment
    
 start: 
         mov ax, stack
         mov ss, ax
         mov sp, 20      ; size of stack is 20 bytes

         mov ax, data
         mov ds, ax
         
         mov cx, 9
         mov bx, 0
         
  init:  push [bx]      
         add bx, 2
         loop init       ; initialize the stack with the original string
         
         mov cx, 9
         mov bx, 0
 rewrite:pop ax          ; stack pops out one word at a time
         mov [bx+1], al  ; I have to reverse the two bytes inside the word
         mov [bx], ah    ; use register ax as temporary storage
         add bx, 2
         loop rewrite    ; rewrite the original string
                                       
    
         mov ax, 004ch
         int 21h 
    
code ends  

end start