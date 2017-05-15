; by sfzhang 2017.5.10
; this program switches the case of a given string's alphabetic character

assume cs:code,ds:data

data segment
    
    db 'sfzhangisA67$%^2GOODGUY',0
    db 40 dup(0)

data ends


code segment
         
  start: mov ax, data
         mov ds, ax
         mov si, 0
         mov di,24            ; if you put 23 here, the program will loop
                              ; forever,because it will write 'S' to this spot overwriting
                              ; the terminating 0
                              ; the di should start from 24
         
   copy: mov al, [si]
         call swcase          ; calling subroutine dealing with al
         mov [di],al
         cmp byte ptr [di], 0
         je ending            ; if the copied byte is 0, goto the end  
         inc si
         inc di
         jmp short copy       ; I didn't use cx as loop counter because we use 0 as string terminator      
         
 swcase: cmp al, 'a'
         jb tolower             
         cmp al, 'z'
         ja return
         and al, 11011111b    ; if al in ['a', 'z'] then switch it to upper case
         jmp short return
  
tolower: cmp al, 'A'
         jb return
         cmp al, 'Z'
         ja return
         or al,  00100000b    ; if al in ['A','Z']  then switch it to lower case  
 return: ret       
         
         
  ending: mov ax, 4c00h
         int 21h
    
code ends

end start
    
