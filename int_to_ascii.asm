
; this program mimics the functionality of itoa
assume cs:code ds:data
 
data segment
    
    dd  423221323       ; string terminated with null
    
data ends 

stack segment   
    
    db 40 dup(0)

stack segment

  start: mov ax, data
         mov ds, ax      
         mov si, 0           
       
         mov ax, [si]
         mov dx, [si+2]
         
         mov cx, 000Ah
         div cx              
         push dx             
       
         mov di, 160*12+35*2 
                             
                             
       
cpychar: mov ah, 05h         
         mov al, ds:[si]     
         cmp al, 0h          
         je  finish          
         mov word ptr es:[di], ax     
         inc si              
         add di, 2           
         jmp short cpychar 
         
       
finish:  mov ax, 4c00h
         int 21h
         
code ends

end start 
        
      