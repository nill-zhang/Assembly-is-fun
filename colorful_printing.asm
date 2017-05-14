
; this program prints a string at the center of the screen
assume cs:code ds:data
 
data segment
    
    db 'hello there!',0        ; string terminated with null
    
data ends
    
code segment

  start: mov ax, 0b800h      
         mov es, ax          ; register es stroes vga memory segment address
       
         mov ax, data
         mov ds, ax          ; register ds stores source string segment address
         mov si, 0           ; si, di stands for source and destination offset address
       
         mov di, 160*12+35*2 ; every character occupies 2 bytes, one is the ascii code
                             ; the other is the display attribute of the character
                             ; 25 rows X 80 columns for one display page, I print string at the center
       
cpychar: mov ah, 05h         ; set the attribute: bg color: black fg color: magenta
         mov al, ds:[si]     ; get the character
         cmp al, 0h          ; the end of the string?
         je  finish          
         mov word ptr es:[di], ax    ; copy from source to dest vga memory for display 
         inc si              ; move to the next character
         add di, 2           ; move to the next target spot
         jmp short cpychar 
         
       
finish:  mov ax, 4c00h
         int 21h
         
code ends

end start 
        
      