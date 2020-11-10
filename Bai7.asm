section .data   
                
                
  
welcome:        db      " Input q to quit"                
w_len:          equ     $ - welcome 
in_msg:         db      0xa, "Enter n: "        
im_len:         equ     $ - in_msg
out_msg:        db      "Sum: "
om_len:         equ     $ - out_msg

section .bss   
n_str:          resb    4       
sum_str:        resb    7

section .text
                        
        global _start   
                        

                       

print:                  
                      
        push    ebx     
        push    eax
        mov     eax,4   
        mov     ebx,1   
        int     0x80    
        pop     eax    
        pop     ebx
        ret             

scan:                 
        push    ebx
        push    eax
        mov     eax,3   
        mov     ebx,0   
        int     0x80
        pop     eax
        pop     ebx
        ret

xTen:                  
        push    ebx
        mov     ebx,eax 
        shl     eax,2   
        add     eax,ebx 
        shl     eax,1
        pop     ebx
        ret

byTen:                  
        push    edx
        push    ecx
        mov     edx,0
        mov     ecx,10
        div     ecx
        mov     ebx,edx
        pop     ecx
        pop     edx
        ret

toInt:                 
        push    ebx
        mov     eax,0
        mov     ebx,0
    .loopStr:           
        call    xTen    
        push    edx    
        mov     edx,0
        mov     dl,byte[ecx+ebx]       
        sub     dl,0x30 ;ascii code of '0'
        add     eax,edx
        pop     edx     ;restore edx
        inc     ebx     ;increment ebx by 1
        cmp     byte[ecx+ebx],0xa
        jle     .return
        cmp     ebx,edx
        jge     .return
        jmp     .loopStr
    .return:
        pop     ebx
        ret

toStr:                  
        push    ebx
        push    eax
        mov     ebx,0
        push    0
    .loopDiv:                 
        call    byTen
        add     ebx,0x30
        push    ebx
        cmp     eax,0
        jg      .loopDiv
        mov     ebx,0
    .loopStr:                  
        pop     eax
        cmp     eax,0
        je      .loopFill
        cmp     ebx,edx
        je      .loopStr        
        mov     byte[ecx+ebx],al       
        inc     ebx
        jmp     .loopStr
    .loopFill:                  
        cmp     ebx,edx
        je      .return
        mov     byte[ecx+ebx],0
        inc     ebx
        jmp     .loopFill
    .return:
        pop     eax
        pop     ebx
        ret

sumN:                
        mov     eax,0
        push    ebx
    .loopN:
        add     eax,ebx
        dec     ebx
        jnz     .loopN
        pop     ebx
        ret

_start:

.main_loop:
        mov     ecx,in_msg
        mov     edx,im_len
        call    print

        mov     ecx,n_str
        mov     edx,4
        call    scan

        cmp     byte[n_str],0x71        
        je      .quit

        call    toInt

        mov     ebx,eax
        call    sumN

        mov     ecx,out_msg
        mov     edx,om_len
        call    print

        mov     ecx,sum_str
        mov     edx,7
        call    toStr

        call    print
        jmp     .main_loop

    .quit:
        mov     ebx,0
        mov     eax,1
        int     0x80
