
; this program switches the case of the string's character

assume cs:code,ds:data

data segment
    
    db 'sfzhangisAGOODGUY',0
    db 20 dup(0)

data ends


code segment
         
         mov ax, data
         mov ds, ax
         mov si, 0
         mov di,17
         
         mov byte ptr [di],[si]
    
code ends    
    