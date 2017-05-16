
; by sfzhang 2017.5.16
; this program prints the system time from CMOS port
assume cs:code,ds:data

data segment
      
   db '2','0',0,0,'/',0,0,'/',0,0,' ',0,0,':',0,0,':',0,0,'$' ; output format string, 0 is placeholder
   
   indices db 2,5,8,11,14,17                                  ; the indices of the above mentioned placeholder in the format string
   
   units   db 9,8,7,4,2,0                                     ; unit numbers of year,month,day,hour,minute,second
                                                              ; in CMOS port
   
data ends   

code segment
   
     
     start: mov ax, data
            mov ds, ax
            mov si, 0
            mov cx, 6          ; six indices to fill(year,month,day,hour,minute,second)
            mov bx, 0 
            
            
    getone: mov al, units[si]
            out 70h, al        ; give the unit number to access
            in al, 71h         ; get the value of the unit
            mov ah, al
            shr ah, 4
            and al, 00001111b  ; every value is 2 BCD code, spit them to ah and al
            mov dl, indices[si]
            mov dh, 0
            mov di, dx         ; di stores the indices to fill in the output format string
            add ah, 30h
            add al, 30h
            mov ds:[bx+di],  ah
            mov ds:[bx+di+1], al
            inc si
            loop getone    
            
            
     
     
     
            mov ax, 0b800h
            mov es, ax
            mov si, 0
            mov di, 160*12+35*2
           
     print: cmp [si], '$'      ; if it is the last character 
            jz finish          ; goto finish
            mov al, [si]
            mov ah, 05h
      next: mov word ptr es:[di], ax ; display one character and its attribute
            inc si
            add di, 2 
            jmp print
            
    finish: mov ax, 4c00h
            int 21h

code ends
end start