section .data
	brl db 0xa
	count db 0
	tmp2 db 0
	res db 0
	temp db 0
section .bss
	num resb 4
	realnumber resb 5
	tmp resb 5
	fac resb 5
section text
	global _start
_start:
	mov eax,0
	mov [realnumber],eax
	
	mov eax,1
	mov [fac],eax
	
	mov eax,3
	mov ebx,2
	mov ecx,num
	mov edx,4
	int 80h
	
	call factorial
	mov ecx,fac
	call printnumber
	
exit:
	mov eax,4
	mov ebx,1
	mov ecx,brl
	mov edx,1
	int 80h	
	
	mov eax,1
	mov ebx,0
	int 80h

factorial:
	l1:
		mov al,[realnumber]
		mov bl,10
		mul bl
		mov [realnumber],al

		mov eax,[realnumber]
		mov ebx,[num]
		sub ebx,'0'
		add eax,ebx
		add ebx,'0'
		mov [num],ebx
		mov [realnumber],eax
		
		mov edx,num
		inc edx
		mov ecx,[edx]
		mov [num],ecx
		
		mov cl,[num]
		cmp cl,48
		mov [num],cl
		jl calcular
		jmp l1

	calcular:
		l3:
			mov al,[fac]
			mov bl,[realnumber]
			mul bl
			mov [realnumber],bl
			mov [fac],al
			
			mov edx,[realnumber]
			dec edx
			mov [realnumber],edx
			
			mov [temp],ah
			l4:
				mov cl,[temp]
				cmp cl,0
				je l4_exit
				
				mov edx,[fac]
				add edx,256
				mov [fac],edx
				
				dec cl
				mov [temp],cl
				jmp l4
			
			l4_exit:
			
			mov cl,[realnumber]
			cmp cl,0
			mov [realnumber],cl
			je back
			jmp l3	
		back:
	ret
	
printnumber:
	    mov al,[ecx]
	    mov bl,10
	    mov [tmp2],al

	l2:
	    mov eax,0
	    mov ebx,0
	    mov ecx,0
	    mov edx,0
	    
	    mov cl,[tmp2]
	    cmp cl,0
	    mov [tmp2],cl
	    je print
	    
	    mov al,[tmp2]
	    mov bl,10
	    div bl
	    
	    mov [tmp2],al
	    add ah,'0'
	    mov [res],ah
	    mov edx,[res]
	    push edx
	    
	    mov edx,[count]
	    inc edx
	    mov [count],edx

	    
	    jmp l2
	    
	print:
	    mov edx,[count]
	    dec edx
	    mov [count],edx
		
	    pop edx
	    mov [res],edx
	    mov ecx,res
	    mov edx,1
	    mov ebx,1
	    mov eax,4
	    int 80h
	    
	    mov cl,[count]
	    cmp cl,0
	    mov [count],cl
	    
	    je exit
	    jmp print
    
    ret
