; by sfzhang 2017.5.15

; this program mimics the functionality of c function itoa
; it converts an integer 423221323 to its string form '423221323'
; and print it on the screen
assume cs:code ds:data
 
data segment
    
    dd  423221323       ; a double word interger
    
data ends 

stack segment   
                        ; a 40 byte stack for storing data
    db 40 dup(0)

stack ends

code segment

  start: mov ax, data
         mov ds, ax      
         mov si, 0           
         
         mov cx, 0      ; register cx stores the number of decimal digits
         
   calc: mov ax, [si+2] ; move the higher 2 bytes to ax 
         mov dx, 0      ; set dx = 0
         
         mov bx, 000Ah  ; regiser bx stores the divisor 10(0Ah)
         div bx
         mov [si+2], ax ; store the quotient back
         
         mov ax, [si]   ; move the lower 2 bytes to ax
         div bx
         mov [si], ax   ; store the quotient back
         
                        
         push dx        ; push remainder to the stack
         inc cx         ; increase cx by 1
   
         cmp word ptr [si], 0   ; check quotient == 0?
         jne calc               ; if not, continue the recursion
       
         mov ax, 0b800h         ; start printing, initialize the display parameters
         mov es, ax
         mov di, 160*12+35*2
          
  print: pop ax                 ; get a decimal digit
         mov ah, 05h            ; color: magenta
         add al, '0'            ; convert the digit to ascii code            
         mov word ptr es:[di], ax          
         add di, 2           
         loop print 
         
       
         mov ax, 4c00h
         int 21h
         
code ends

end start 
        
      