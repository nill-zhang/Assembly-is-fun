
; by sfzhang @2017.5.9
; this program will make a copy of itself to the memory location at 0200h:0h 
assume cs: copy

copy segment
    
 start:  mov ax, cs
         mov ds, ax      ; let es register points to the source(cs) segment address
         
         mov ax, 0200h
         mov es, ax      ; let es register points to the target(es) segment address 
         
         
         mov bx, 0h      ; bx stores current unit
    
                         
               
    do:  mov al, [bx]    ; copy source to al(one byte)
         mov es:[bx], al ; copy al to target(one byte)
         inc bx          ; shift to the next    
         
         loop do         ; wait, where is the loop counter
                         ; I didn't define and assign a value to cx
                         ; because cx stores the length of the program in bytes
                         ; by default
    
    
         mov ax, 004ch
         int 21h 
    
copy ends
end start